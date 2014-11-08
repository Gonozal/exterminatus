class RaidBoss < ActiveRecord::Base
  enum raid: [:genetic_archives, :datascape]
  enum boss_type: [:boss, :miniboss, :challenge]

  default_scope -> {order(:raid, :floor, :position)}
  has_many :boss_preferences

  def shorthand
    case name
      when "Genetic Monstrosity" then "Monstrosity"
      when "Hideously Malformed Mutant" then "HMM"
      when "Experiment X-89" then "X-89"
      when "Gravitron Operator " then "Gravitron"
      when "Kuralak the Defiler " then "Kuralak"
      when "Fetid Miscreation " then "Fetic M."
      when "Floor 1 Challanges" then "F1 Challange"
      when "Phagetech Guardians" then "Guardians"
      when "Phage Maw" then "Phage Maw"
      when "Phagetech Prototypes" then "Prototypes"
      when "Phageborn Convergence" then "Convergence"
      when "Malfunctioning Gear" then "Gear"
      when "Malfunctioning Dynamo" then "Dynamo"
      when "Malfunctioning Piston" then "Piston"
      when "Malfunctioning Battery" then "Battery"
      when "Dreadphage Ohmna" then "Ohmna"
      when "Floor 2 Challanges" then "F2 Challange"
    end
  end
end
