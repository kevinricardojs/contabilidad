class AddPeriodoToLibroDiario < ActiveRecord::Migration
  def change
    add_column :libro_diarios, :periodo, :integer
  end
end
