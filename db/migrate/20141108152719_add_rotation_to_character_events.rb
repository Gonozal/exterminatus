class AddRotationToCharacterEvents < ActiveRecord::Migration
  def change
    add_column :character_events, :rotation, :integer, default: 3
    add_index :character_events, :rotation, unique: false
  end
end
