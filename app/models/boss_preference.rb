class BossPreference < ActiveRecord::Base
  belongs_to :character
  belongs_to :raid_boss
  enum preference: [:need, :gear, :want, :skip]
  enum progression: [:not_started, :progression, :killed]

  default_scope -> { includes(:raid_boss) }

  def self.create_dummy_preferences
    return false unless RaidBoss.any? and Character.any?
    bosses = RaidBoss.all
    if BossPreference.count == 0
      missing_chars = Character.all
    else
      missing_char_ids = BossPreference.all.map(&:character_id).uniq
      missing_chars = Character.where("id not in (?)", missing_char_ids).all
    end
    missing_chars.each do |c|
      bosses.each do |b|
        c.boss_preferences.create(raid_boss_id: b.id)
      end
    end
  end
end
