class CreateConsumidos < ActiveRecord::Migration
  def change
    create_table :consumidos do |t|
      t.references :folio, index: true, foreign_key: true
      t.string :mes
      t.integer :pag_usadas
      t.integer :position

      t.timestamps null: false
    end
  end
end
