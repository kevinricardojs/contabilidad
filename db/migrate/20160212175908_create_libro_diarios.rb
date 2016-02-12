class CreateLibroDiarios < ActiveRecord::Migration
  def change
    create_table :libro_diarios do |t|
      t.references :establecimiento, index: true, foreign_key: true
      t.string :mes
      t.string :year

      t.timestamps null: false
    end
  end
end
