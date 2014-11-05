class CharacterEvent < ActiveRecord::Base
  belongs_to :character
  belongs_to :computed_event

  validates_with SignupStatusValidator

  enum status: ["Not Signed", "Available", "Unavailable", "Tentative"]

  default_scope -> { includes(:computed_event) }

  scope :with_signups, ->(events) do
    eager_load(character_events: :computed_event).eager_load(:team).
      order("teams.name ASC, characters.klass ASC, characters.role DESC, characters.name ASC")
  end

  # CSS-Classes for the signup status container
  def signup_css
    css_class = []
    css_class << status.downcase.tr(" ", "-")
    css_class << "signup"
    css_class << "past" if computed_event.date < Date.today
    css_class.join " "
  end

  def note_text
    note.blank?? "No note" : note
  end
end
