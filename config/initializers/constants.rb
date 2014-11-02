WS_CLASS_ROLES = {
  tank: ["Engineer", "Warrior", "Stalker"],
  healer: ["Medic", "Spellslinger", "Esper"],
  dps: ["Engineer", "Warrior", "Stalker", "Medic", "Spellslinger", "Esper"]
}

def enum_to_editable_hash(hash)
  hash.map do |v, k|
    { value: v, text: v}
  end
end
