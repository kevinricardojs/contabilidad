class CreateCuentas < ActiveRecord::Migration
  def change
    create_table :cuentas do |t|
      t.string :nombre
      t.string :nombre_
      t.string :debe
      t.string :haber
      t.references :partida, index: true, foreign_key: true
      t.integer :posicion

      t.timestamps null: false
    end
  end
end
