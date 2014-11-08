class RaidBoss < ActiveRecord::Base
  enum raid: [:genetic_archives, :datascape]
  enum boss_type: [:boss, :miniboss, :challenge]

  default_scope -> {order(:raid, :floor, :position)}
  has_many :boss_preferences

  def shorthand
    case name
      when "Genetic Monstrosity" then "Monstr"
      when "Hideously Malformed Mutant" then "HMM"
      when "Experiment X-89" then "X-89"
      when "Gravitron Operator " then "Gravitron"
      when "Kuralak the Defiler " then "Kuralak"
      when "Fetid Miscreation " then "Fetit M."
      when "Floor 1 Challanges" then "Challenge1"
      when "Phagetech Guardians" then "Guardians"
      when "Phage Maw" then "Phagemaw"
      when "Phagetech Prototypes" then "Prototypes"
      when "Phageborn Convergence" then "Council"
      when "Malfunctioning Gear" then "Gear"
      when "Malfunctioning Dynamo" then "Dynamo"
      when "Malfunctioning Piston" then "Piston"
      when "Malfunctioning Battery" then "Battery"
      when "Dreadphage Ohmna" then "Ohmna"
      when "Floor 2 Challanges" then "Challenge2"
    end
  end
end
