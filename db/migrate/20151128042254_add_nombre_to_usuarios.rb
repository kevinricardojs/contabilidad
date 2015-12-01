class AddNombreToUsuarios < ActiveRecord::Migration
  def change
  	add_column :usuarios, :nombre, :string
  	add_column :usuarios, :apellido, :string
  end
end
