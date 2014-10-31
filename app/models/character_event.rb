class CharacterEvent < ActiveRecord::Base
  belongs_to :character
  belongs_to :computed_event, dependent: :destroy

  validates_with SignupStatusValidator

  scope :with_signups, ->(events) do
    eager_load(character_events: :computed_event).eager_load(:team).
      order("teams.name ASC, characters.klass ASC, characters.role DESC, characters.name ASC")
  end

  def signup
    self.status = 0 unless (0..3).include?(status)
    EVENT_STATUS[status]
  end

  def signup_css
    css_class = []
    css_class << signup.downcase.tr(" ", "-")
    css_class << "signup"
    if computed_event.date < Date.today
      css_class << "past"
    else
      css_class << "rest-in-place"
    end
    css_class.join " "
  end
end
