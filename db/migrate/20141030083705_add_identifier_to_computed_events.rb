class AddIdentifierToComputedEvents < ActiveRecord::Migration
  def change
    add_column :computed_events, :identifier, :string
  end
end
