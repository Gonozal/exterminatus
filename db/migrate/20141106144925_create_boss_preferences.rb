class CreateBossPreferences < ActiveRecord::Migration
  def change
    create_table :boss_preferences do |t|
      t.references :character
      t.references :raid_boss
      t.integer :preference, default: 2, null: false
      t.integer :progression, default: 0, null: false
      t.timestamps
    end
    add_index :boss_preferences, :character_id, unique: false
    add_index :boss_preferences, :raid_boss_id, unique: false
  end
end
