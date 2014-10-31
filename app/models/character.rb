class Character < ActiveRecord::Base
  attr_accessor :team_shorthand

  belongs_to :team
  has_many :character_events
  has_many :computed_events, through: :character_events

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

  scope :with_signups, ->(events) do
    eager_load(character_events: :computed_event).eager_load(:team).
      order("teams.name ASC, characters.klass ASC, characters.role DESC, characters.name ASC")
  end

  def update_signups(date, status)
    old_signups = signups.clone
    old_signups[date.to_s] = status
    self.signups = old_signups
  end

  def sorted_character_events
    character_events.sort do |x, y|
      x.computed_event.date <=> y.computed_event.date
    end
  end

  def assoc_character_events
    @aces ||= sorted_character_events.each_with_object({}) do |ce, h|
      h[ce.computed_event_id] = ce
    end
  end

  def signups(event_id)
    if assoc_character_events.has_key? event_id
      assoc_character_events[event_id]
    else
      ce = character_events.build
      ce.computed_event_id = event_id
      ce.status = 0
      ce.save
      ce
    end
  end
end
