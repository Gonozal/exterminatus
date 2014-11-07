class Character < ActiveRecord::Base
  attr_accessor :team_shorthand

  belongs_to :team
  belongs_to :user
  has_many :character_events
  has_many :computed_events, through: :character_events

  has_many :boss_preferences
  has_many :raid_bosses, -> {order 'raid_boss.raid, raid_boss.floor, raid_boss.position'},
           through: :boss_preferences


  validates :name, presence: true, uniqueness: true

  validates_with RoleValidator

  enum klass: ["Engineer", "Warrior", "Stalker", "Medic", "Spellslinger", "Esper"]
  enum role: ["Tank", "Healer", "DPS"]


  scope :with_signups, ->(events) do
    eager_load(character_events: :computed_event).eager_load(:team).
      where("computed_events.id in (?)", events.map(&:id)).
      order("teams.name, characters.klass, characters.role DESC, characters.name").
      order("computed_events.date")
  end

  scope :for_next_raid, ->(event) do
    with_boss_preferences.eager_load(:character_events).
      where(character_events: {computed_event_id: event.id, status: 1}).
      order(:name)
  end

  scope :with_boss_preferences, -> do
    includes(boss_preferences: :raid_boss).
      order('raid_bosses.raid, raid_bosses.floor, raid_bosses.position')
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
end
