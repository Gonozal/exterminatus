json.array! Team.all do |team|
  json.id team.id
  json.name team.name
  json.shorthand team.shorthand
end
