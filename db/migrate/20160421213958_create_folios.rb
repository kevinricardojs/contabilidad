class CreateFolios < ActiveRecord::Migration
  def change
    create_table :folios do |t|
      t.integer :libro
      t.integer :paginas
      t.string :year

      t.timestamps null: false
    end
  end
end
