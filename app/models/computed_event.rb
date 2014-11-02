# coding: iso-8859-1
class ComputedEvent < ActiveRecord::Base
  include IceCube  # Saves us from writing IceCube:: every time
  has_many :character_events, dependent: :destroy
  has_many :characters, through: :character_events
  belongs_to :event

  default_scope -> { includes(:event) }

  enum status: ["Not Signed", "Available", "Unavailable", "Tentative"]

  scope :next, ->(amount) do
    where("date >= ?", Date.today).order(date: :asc).limit(amount)
  end
  scope :prev, ->(amount) do
    where("date < ?", Date.today).order(date: :desc).limit(amount).reverse
  end

  def id_string(event_id)
    days_since_launch = (date - Date.new(2014,5,8)).to_i
    "#{days_since_launch}-#{event_id}"
  end

  # Re-compute all schedules
  def self.update_schedules(date_range = Date.today..(Date.today + 45.days))
    events = computed_events(date_range)
    # Delete all events that are no longer valid
    delete_removed_events(events, date_range)

    # Get a list of the old event identifiers
    old_event_idents = ComputedEvent.where(date: date_range).map do |v|
      v.identifier
    end

    events.delete_if do |e|
      old_event_idents.include? e.identifier
    end

    ComputedEvent.transaction do
      events.each do |e|
        e.save
      end
    end
  end

  protected
  # returns an array of computed events based on Event-rules queried from the DB
  def self.computed_events(date_range)
    recurring_events = Event.where(event_type: 0)
    canceled_events = Event.where(event_type: 2)

    # Build A schedule for every recurring event in the database
    # First, the recurring event itself will be parsed and added to the schedule
    # Then any exception on that weekday during the lifetime of the event
    # will be added as an exception to the recurring event
    recurring_events.map do |re|
      s = Schedule.new(re.start_date)
      # Create a rule for the recurring event itself and add it to the schedule
      rr = Rule.weekly(1, :monday).day(re.weekday).until(re.end_date)
      s.add_recurrence_rule rr
      # Add canceled events to schedule if they are of concern to it
      # Also delete it from the array so the next iteration will be faster
      canceled_events.to_a.delete_if do |ce|
        if re.weekday == ce.weekday and re.start_date..re.end_date === ce.date
          s.add_exception_time ce.date
          true
        end
      end

      # Get all occurences in given date interval
      s.occurrences_between(date_range.first, date_range.last).map do |o|
        ComputedEvent.build(event_id: re.id, date: o.to_date)
      end
      # Add one-time events to the array
    end.flatten + Event.where(event_type: 1, date: date_range).map do |e|
      ComputedEvent.build(event_id: e.id, date: e.date)
    end
  end

  # Deletes events in selected date range that are not in new_events
  def self.delete_removed_events(new_events, date_range)
    if new_events.any?
      ComputedEvent.where("identifier not in (?) and date BETWEEN ? AND ?" ,
                          new_events.map{ |e| e.identifier },
                          date_range.first,
                          date_range.last
                         ).destroy_all
    else
      ComputedEvent.where(date: date_range).destroy_all
    end
  end

  # same as "new" but also generates the identifier
  def self.build(params)
    event_id = params.delete :event_id
    e = ComputedEvent.new params
    e.identifier = e.id_string event_id
    e.event_id = event_id
    e
  end
end
