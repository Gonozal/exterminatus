class CreateRaidBosses < ActiveRecord::Migration
  def change
    create_table :raid_bosses do |t|
      t.string :name, null: false
      t.integer :raid, null: false
      t.integer :boss_type, null: false
      t.integer :floor
      t.integer :position


      t.timestamps
    end
    add_index :raid_bosses, :raid, unique: false
    add_index :raid_bosses, :boss_type, unique: false
  end
end
