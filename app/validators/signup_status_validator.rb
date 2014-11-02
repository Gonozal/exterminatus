class SignupStatusValidator < ActiveModel::Validator
  def validate(record)
    unless record.computed_event.date >= Date.today
      record.errors[:status] << "Can't change status for past events"
    end
  end
end
