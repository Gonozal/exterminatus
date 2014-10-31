class RemoveSignupsFromCharacters < ActiveRecord::Migration
  def up
    remove_column :characters, :signups, :json
  end

  def down
    add_column :characters, :signups, :json
  end
end
