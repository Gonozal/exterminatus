class Team < ActiveRecord::Base
  has_many :characters

  validates :name, presence: true, uniqueness: true
  validates :shorthand, presence: true, uniqueness: true
end
