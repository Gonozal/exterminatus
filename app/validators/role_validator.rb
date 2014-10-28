class RoleValidator < ActiveModel::Validator
  def validate(record)
    role = record.role.downcase.to_sym

    condition = (WS_CLASS_ROLES.has_key?(role) and WS_CLASS_ROLES[role].include? record.klass)
    unless condition
      record.errors[:role] << "#{record.klass.pluralize} can't be #{record.role.pluralize}"
    end
  end
end
