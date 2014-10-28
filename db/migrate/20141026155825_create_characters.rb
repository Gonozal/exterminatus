class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :klass
      t.string :role
      t.references :team

      t.timestamps
    end
  end
end
