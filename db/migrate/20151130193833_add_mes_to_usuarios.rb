class AddMesToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :mes, :string, default:"selecciona mes"
    add_column :usuarios, :year, :string, default:"Selecciona año"
  end
end
