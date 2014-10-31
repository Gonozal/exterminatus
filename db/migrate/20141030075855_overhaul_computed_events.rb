class OverhaulComputedEvents < ActiveRecord::Migration
  def change
    remove_column :computed_events, :schedule, :text
    add_column :computed_events, :date, :date
  end
end
