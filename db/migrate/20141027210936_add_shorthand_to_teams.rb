# coding: iso-8859-1
class AddShorthandToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :shorthand, :string
  end
end
