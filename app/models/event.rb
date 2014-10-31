class Event < ActiveRecord::Base
  has_many :computed_events

  validates :name, presence: true
  validates :date, presence: true
  validates :event_type, presence: true, inclusion: { in: 0..2 }
  validates_with EventValidator

  after_validation :update_weekday
  after_save :update_schedules
  after_update :update_schedules
  after_destroy :update_schedules

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

  # Convert the integer event-type into something readable
  def type_string
    EVENT_TYPES[event_type]
  end

  # returns all events that ever happened
  def self.all_events
    one_time_events = Event.where(event_type: 1).map do |e|
      {name: e.name, date: e.date}
    end
    events = ComputedEvent.recurring_events + one_time_events
    events.sort do |x, y|
      x[:date] <=> y[:date]
    end
  end

  # Returns the last 5 events from this day backwards
  def self.last(amount)
    next_or_last(:last, amount)
  end

  # Returns the next 5 events from this day forwards
  def self.next(amount)
    next_or_last(:next, amount)
  end

  def self.type_from_string(string)
    case string
      when "Recurring" then 0
      when "One-Time" then 1
      when "Canceled" then 2
      else nil
    end
  end

  protected
  # Every time an event is updated, also save the weekday to make timetables fater
  def update_weekday
    self.weekday = date.wday
  end

  def update_schedules
    ComputedEvent.update_schedules
  end

  # Returns either the next 5 or last 5 events that happened
  def self.next_or_last(query_type, amount)
    recurring_events = case query_type
      when :next then ComputedEvent.next(amount)
      when :last then ComputedEvent.last(amount)
    end
    time_range = case query_type
      when :next then Date.today..recurring_events.last[:date]
      when :last then recurring_events.first[:date]..Date.today
    end

    one_time_events = Event.where(event_type: 1, date: time_range).map do |e|
      {name: e.name, date: e.date}
    end

    puts one_time_events

    events = (recurring_events + one_time_events).compact.sort do |x, y|
      x[:date] <=> y[:date]
    end

    return case query_type
      when :next then events.take(amount)
      when :last then events.drop(events.size - amount)
    end
  end
end
