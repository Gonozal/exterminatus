class Role < ActiveRecord::Base
  # devise/cancan setup
  has_and_belongs_to_many :users
end
