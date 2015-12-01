class AddCamposToUsuarios < ActiveRecord::Migration
  def change
    add_reference :usuarios, :contribuyente, index: true, foreign_key: true
    add_reference :usuarios, :establecimiento, index: true, foreign_key: true
  end
end
