class CreateCharacterEvents < ActiveRecord::Migration
  def change
    create_table :character_events do |t|
      t.references :character
      t.references :computed_event
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
