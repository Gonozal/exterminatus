class CreateComputedEvents < ActiveRecord::Migration
  def change
    create_table :computed_events do |t|
      t.date :date
      t.string :identifier
      t.integer :event_id
      t.timestamps
    end
  end
end
