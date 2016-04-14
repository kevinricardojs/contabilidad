class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.references :establecimiento, index: true, foreign_key: true
      t.integer :year
      t.integer :periodo

      t.timestamps null: false
    end
  end
end
