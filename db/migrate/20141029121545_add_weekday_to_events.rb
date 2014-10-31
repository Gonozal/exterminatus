class AddWeekdayToEvents < ActiveRecord::Migration
  def change
    add_column :events, :weekday, :integer
  end
end
