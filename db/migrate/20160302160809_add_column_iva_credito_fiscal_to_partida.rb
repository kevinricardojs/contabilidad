class AddColumnIvaCreditoFiscalToPartida < ActiveRecord::Migration
  def change
    add_column :partidas, :iva_credito_fiscal, :decimal, precision: 10, scale: 2
  end
end
