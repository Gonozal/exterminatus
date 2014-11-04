class MakeCharactersClaimable < ActiveRecord::Migration
  def change
    add_column :characters, :user_id, :integer

    add_index :characters, :user_id, unique: false
    add_index :characters, :team_id, unique: false
    add_index :computed_events, :identifier, unique: true
    add_index :computed_events, :event_id, unique: false
    add_index :character_events, :character_id, unique: false
    add_index :character_events, :computed_event_id, unique: false
  end
end
