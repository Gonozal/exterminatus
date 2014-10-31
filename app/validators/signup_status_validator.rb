class SignupStatusValidator < ActiveModel::Validator
  def validate(record)
    unless record.status.kind_of? String or EVENT_STATUS.size > record.status
      record.errors[:status] << "not a valid status"
    end
  end
end
