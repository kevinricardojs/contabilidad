class CreatePartidas < ActiveRecord::Migration
  def change
    create_table :partidas do |t|
      t.string :dia

      t.timestamps null: false
    end
  end
end
