class Character < ActiveRecord::Base
  attr_accessor :team_shorthand

  belongs_to :team
  has_many :character_events
  has_many :computed_events, through: :character_events

  validates :name, presence: true, uniqueness: true

  validates_with RoleValidator

  enum klass: ["Engineer", "Warrior", "Stalker", "Medic", "Spellslinger", "Esper"]
  enum role: ["Tank", "Healer", "DPS"]

  scope :with_signups, ->(events) do
    eager_load(character_events: :computed_event).eager_load(:team).
      order("teams.name ASC, characters.klass ASC, characters.role DESC, characters.name ASC")
  end

  def edit_data(attribute)
    @teams ||= Team.all.to_a
    input_type = (attribute == "name")? "text" : "select"
    select_hash = case attribute
      when "klass"
        {source: enum_to_editable_hash(Character.klasses).to_json}
      when "role"
        {source: enum_to_editable_hash(Character.roles).to_json}
      when "team_id"
        {source: @teams.each_with_object({}) {|t, h| h[t.id] = t.name}.to_json}
      else {}
    end
    {
      type: input_type,
      url: "characters/#{id}",
      resource: "character",
      name: attribute
    }.merge(select_hash)
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

  protected
  def sorted_character_events
    return [] unless character_events.any?
    character_events.sort do |x, y|
      x.computed_event.date <=> y.computed_event.date
    end
  end

  def assoc_character_events
    @aces ||= sorted_character_events.each_with_object({}) do |ce, h|
      h[ce.computed_event_id] = ce
    end
  end
end
