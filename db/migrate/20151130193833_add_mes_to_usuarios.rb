class AddMesToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :mes, :integer, default: 0
    add_column :usuarios, :year, :integer, default: 0
  end
end
