json.id @character.id
json.name @character.name
json.klass @character.klass
json.role @character.role
json.team_shorthand (@character.team.blank?)? "" : @character.team.shorthand
