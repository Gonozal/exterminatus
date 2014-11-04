class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :promote_first_user

  # cancan setup
  has_and_belongs_to_many :roles
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  has_many :characters

  enum rank: ["unapproved", "approved", "admin"]

  validates_with UserRankValidator

  def edit_data(attribute)
    input_type = (attribute == "rank")? "select" : "text"
    select_hash = case attribute
      when "rank"
        {source: enum_to_editable_hash(User.ranks).to_json}
      else {}
    end
    {
      type: input_type,
      url: "accounts/#{id}",
      resource: "user",
      name: attribute
    }.merge(select_hash)
  end

  protected
  def promote_first_user
    if User.all.count == 1
      User.first.admin!
    end
  end
end
