class AddMesToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :mes, :string
    add_column :usuarios, :year, :string
  end
end
