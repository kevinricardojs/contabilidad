class AddDisponiblesToFolios < ActiveRecord::Migration
  def change
    add_column :folios, :disponibles, :integer
  end
end
