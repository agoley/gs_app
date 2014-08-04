class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.string :console
      t.float :ask_price
      t.string :condition
      t.boolean :original_packaging
      t.integer :seller_id

      t.timestamps
    end
  end
end
