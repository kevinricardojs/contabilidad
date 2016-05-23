class CreateLibroVs < ActiveRecord::Migration
  def change
    create_table :libro_vs do |t|
      t.references :establecimiento, index: true, foreign_key: true
      t.integer :mes
      t.integer :year

      t.timestamps null: false
    end
  end
end
