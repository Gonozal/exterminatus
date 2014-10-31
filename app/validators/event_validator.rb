class EventValidator < ActiveModel::Validator
  def validate(event)
    # Check Recurring events (need start&end date)
    if event.event_type == 0
      if event.start_date.blank?
        event.errors[:start_date] << "Recurring events need a start date"
      elsif event.end_date.blank?
        event.errors[:end_date] << "Recurring events need an end date"
      end
    end
  end
end
