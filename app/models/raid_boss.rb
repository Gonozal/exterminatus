class RaidBoss < ActiveRecord::Base
  enum raid: [:genetic_archives, :datascape]
  enum boss_type: [:boss, :miniboss, :challenge]

  default_scope -> {order(:raid, :floor, :position)}
  has_many :boss_preferences
end
