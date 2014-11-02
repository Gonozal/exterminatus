class ChangeCharacterRoleAndKlassToInteger < ActiveRecord::Migration
  def change
    remove_column :characters, :klass, :string
    add_column :characters, :klass, :integer

    remove_column :characters, :role, :string
    add_column :characters, :role, :integer, default: 2
  end
end
