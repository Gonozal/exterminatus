class AddNoteToSignupStatus < ActiveRecord::Migration
  def change
    add_column :character_events, :note, :string, default: ""
  end
end
