class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :klass
      t.integer :role
      t.references :team

      t.timestamps
    end
  end
end
