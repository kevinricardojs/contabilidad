class AddUsuarioToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :usuario, :string
    add_index :usuarios, :usuario, unique: true
  end
end
