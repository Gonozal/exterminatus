class Event < ActiveRecord::Base
  has_many :computed_events

  validates :name, presence: true
  validates :date, presence: true
  validates_with EventValidator

  after_validation :update_weekday
  after_save :update_schedules
  after_update :update_schedules
  after_destroy :update_schedules

  enum event_type: ["Recurring", "One-Time", "Canceled"]

  #Strftime format
  def format
    self.class.format
  end

  def self.format
    "%d/%m/%Y"
  end

  def date_str
    date.present?? date.strftime(format) : ""
  end

  def start_date_str
    start_date.present?? start_date.strftime(format) : ""
  end

  def end_date_str
    end_date.present?? end_date.strftime(format) : ""
  end

  # Returns the last 5 events from this day backwards
  def self.last(amount)
    next_or_last(:last, amount)
  end

  # Returns the next 5 events from this day forwards
  def self.next(amount)
    next_or_last(:next, amount)
  end

  def edit_data(attribute)
    input_type = case attribute
      when "name" then "text"
      when "date" then "date"
      when "start_date" then "date"
      when "end_date" then "date"
      when "event_type" then "select"
      else "text"
    end
    select_hash = case attribute
      when "event_type"
        {source: enum_to_editable_hash(Event.event_types).to_json}
      else {}
    end
    {
      type: input_type,
      url: "events/#{id}",
      resource: "event",
      name: attribute
    }.merge(select_hash)
  end

  protected
  # Every time an event is updated, also save the weekday to make timetables fater
  def update_weekday
    self.weekday = date.wday
  end

  def update_schedules
    ComputedEvent.update_schedules
  end
end
