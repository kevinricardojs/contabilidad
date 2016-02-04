class CreateTipoDeGastos < ActiveRecord::Migration
  def change
    create_table :tipo_de_gastos do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
