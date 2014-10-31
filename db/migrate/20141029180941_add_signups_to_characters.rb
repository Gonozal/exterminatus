class AddSignupsToCharacters < ActiveRecord::Migration
  def up
    add_column :characters, :signups, :json
  end

  def down
    remove_column :characters, :signups, :json
  end
end
