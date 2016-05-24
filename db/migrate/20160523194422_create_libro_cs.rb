class CreateLibroCs < ActiveRecord::Migration
  def change
    create_table :libro_cs do |t|
      t.references :establecimiento, index: true, foreign_key: true
      t.integer :mes
      t.integer :year

      t.timestamps null: false
    end
  end
end
