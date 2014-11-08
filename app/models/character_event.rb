class CharacterEvent < ActiveRecord::Base
  belongs_to :character
  belongs_to :computed_event

  validates_with SignupStatusValidator

  enum status: ["Not Signed", "Available", "Unavailable", "Tentative"]
  enum rotation: [:starting_lineup, :benched, :sitting_out, :not_set]


  scope :with_signups, ->(events) do
    eager_load(character_events: :computed_event).eager_load(:team).
      order("teams.name ASC, characters.klass ASC, characters.role DESC, characters.name ASC")
  end

  def self.size_class(rotation)
    (rotation == "starting_lineup")? "col-md-4" : "col-md-2"
  end

  def self.list_class(rotation)
    (rotation == "starting_lineup")? "list-two" : ""
  end

  # CSS-Classes for the signup status container
  def signup_css
    css_class = []
    css_class << status.downcase.tr(" ", "-")
    css_class << "signup"
    css_class << "past" if computed_event.date < Date.today
    css_class.join " "
  end

  def self.chars_to_update(events)
    return [] unless events.present?
    event_list = events.map(&:id).join ","
    Character.all.includes(:character_events).
      joins("LEFT OUTER JOIN character_events AS ce
                        ON ce.character_id = characters.id AND
                        ce.computed_event_id IN (#{event_list})").
      having("COUNT(ce.id) < ?", events.count).
      group("characters.id")
  end

  def self.create_dummy_char_events(events)
    char_ids = chars_to_update(events).map(&:id)
    return false unless char_ids.present? and events.present?

    CharacterEvent.transaction do
      Character.all.eager_load(:character_events).where(id: char_ids).each do |c|
        ids = c.character_events.map(&:computed_event_id)
        events.each do |e|
          unless ids.include? e.id
            c.character_events.create(computed_event_id: e.id)
          end
        end
      end
    end
  end
end
