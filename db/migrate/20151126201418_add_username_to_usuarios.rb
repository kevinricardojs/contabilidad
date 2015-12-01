class AddUsernameToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :username, :string
    add_index :usuarios, :username, unique: true
  end
end
