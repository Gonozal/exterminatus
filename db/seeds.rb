# This file should contain all the record creation needed to seed the database with its default values. # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup). #
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if RaidBoss.count == 0
  boss_list = [
    {
      name: "Genetic Monstrosity", raid: 0,
      boss_type: 1, floor: 1, position: 0
    }, {
      name: "Hideously Malformed Mutant", raid: 0,
      boss_type: 1, floor: 1, position: 1
    },{
      name: "Experiment X-89", raid: 0,
      boss_type: 0, floor: 1, position: 2
    },{
      name: "Gravitron Operator ", raid: 0,
      boss_type: 1, floor: 1, position: 3
    },{
      name: "Kuralak the Defiler ", raid: 0,
      boss_type: 0, floor: 1, position: 4
    },{
      name: "Fetid Miscreation ", raid: 0,
      boss_type: 1, floor: 1, position: 5
    },{
      name: "Floor 1 Challanges", raid: 0,
      boss_type: 2, floor: 1, position: 6
    },{
      name: "Phagetech Guardians", raid: 0,
      boss_type: 1, floor: 2, position: 0
    },{
      name: "Phage Maw", raid: 0,
      boss_type: 0, floor: 2, position: 1
    },{
      name: "Phagetech Prototypes", raid: 0,
      boss_type: 0, floor: 2, position: 2
    },{
      name: "Phageborn Convergence", raid: 0,
      boss_type: 0, floor: 2, position: 3
    },{
      name: "Malfunctioning Gear", raid: 0,
      boss_type: 1, floor: 2, position: 4
    },{
      name: "Malfunctioning Dynamo", raid: 0,
      boss_type: 1, floor: 2, position: 5
    },{
      name: "Malfunctioning Piston", raid: 0,
      boss_type: 1, floor: 2, position: 6
    },{
      name: "Malfunctioning Battery", raid: 0,
      boss_type: 1, floor: 2, position: 7
    },{
      name: "Dreadphage Ohmna", raid: 0,
      boss_type: 0, floor: 2, position: 8
    },{
      name: "Floor 2 Challanges", raid: 0,
      boss_type: 2, floor: 2, position: 9
    }
  ]
  boss_list.each do |b|
    RaidBoss.create(b)
  end
end
if User.count == 0
  account = User.create(name: "Gonozal", email: "linksoeren@googlemail.com",
                          password: "password", password_confirmation: "password")
  account.admin!
  team = Team.create(name: "Inoas Angles", shorthand: "RT1", )
  Character.create(name: "Apialis Redstar", klass: 2, role: 2, team: team,
                   user: account)
  Character.create(name: "Maviik PewPew", klass: 4, role: 2, team: team)
  Character.create(name: "Inoa Quinn", klass: 4, role: 2, team: team)
  Character.create(name: "Sickie", klass: 4, role: 1, team: team)
end

if Event.count == 0
  Event.create(name: "Test Raid", date: Date.today, start_date: Date.today,
              end_date: Date.today + 1.year)
end
