class ChangeComputedEventsScheduleFromStringToText < ActiveRecord::Migration
  def up
    change_column :computed_events, :schedule, :text
  end

  def down
    change_column :computed_events, :schedule, :string
  end
end
