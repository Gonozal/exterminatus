class EventStatus
  def self.new_signup_hash(events)
    role_hash = {
      "Total" => [],
      "Tank" => [],
      "Healer" => [],
      "DPS" => []
    }
    event_hash = {}
    ComputedEvent.where("id in (?)", events.map(&:id)).each do |e|
      event_hash[e.id] = role_hash.clone
    end
    statuses = {
      "Available" => event_hash.clone,
      "Tentative" => event_hash.clone,
      "Unavailable" => event_hash.clone,
      "Not Signed" => event_hash.clone
    }

    signup_status = {}
    Team.select(:id, :name, :shorthand).all.each do |t|
      signup_status[t.id] = {
        team_name: t.name,
        team_shorthand: t.shorthand,
        status: statuses.deep_dup
      }
    end
    signup_status
  end


  def self.status_hash(events = ComputedEvent.prev(1) + ComputedEvent.next(4))
    signup_hash = new_signup_hash(events)
    characters = Character.all.with_signups(events).load
    characters.each do |c|
      c.character_events.each do |ce|
        signup_hash[c.team.id][:status][ce.status][ce.computed_event_id][c.role] << c.name
        signup_hash[c.team.id][:status][ce.status][ce.computed_event_id]["Total"] << c.name
      end
    end
    signup_hash
  end
end
