class CreateComputedEvents < ActiveRecord::Migration
  def change
    create_table :computed_events do |t|
      t.string :name
      t.text :schedule
      t.timestamps
    end
  end
end
