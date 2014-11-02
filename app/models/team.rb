class Team < ActiveRecord::Base
  has_many :characters

  validates :name, presence: true, uniqueness: true
  validates :shorthand, presence: true, uniqueness: true

  def edit_data(attribute)
    {
      type: "text",
      url: "teams/#{id}",
      resource: "team",
      name: attribute
    }
  end
end
