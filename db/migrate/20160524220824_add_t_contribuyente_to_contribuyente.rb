class AddTContribuyenteToContribuyente < ActiveRecord::Migration
  def change
    add_column :contribuyentes, :t_contribuyente, :integer
  end
end
