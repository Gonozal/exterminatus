class SignupStatusValidator < ActiveModel::Validator
  def validate(record)
    unless record.computed_event.date >= Date.today or !record.status_changed?
      record.errors[:status] << "Can't change status for past events"
    end
  end
end
