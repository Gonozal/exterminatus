class AddEventIdToComputedEvent < ActiveRecord::Migration
  def change
    add_column :computed_events, :event_id, :integer
    remove_column :computed_events, :name, :string
  end
end
