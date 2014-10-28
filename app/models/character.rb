class Character < ActiveRecord::Base
  attr_accessor :team_shorthand
  belongs_to :team

  validates :name, presence: true, uniqueness: true
  validates :klass, inclusion: {
              in: %w(Engineer Warrior Stalker Medic Spellslinger Esper),
              message: "%{value} is not a valid class"
            }
  validates :role, inclusion: {
              in: %w(DPS Healer Tank),
              message: "%{value} is not a valid Role"
            }
  validates_with RoleValidator
end
