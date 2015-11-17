class CreateCuentaContables < ActiveRecord::Migration
  def change
    create_table :cuenta_contables do |t|
      t.string :nombre
      t.integer :tipo

      t.timestamps null: false
    end
  end
end
