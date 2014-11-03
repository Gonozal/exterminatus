class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.date :start_date # only relevant for recurring events
      t.date :end_date   # only relevant for recurring events
      t.integer :event_type    # 0: Recurring, 1: Single-Time Event, 2: Excluded Event
      t.integer :weekday

      t.timestamps
    end
  end
end
