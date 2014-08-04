class AddNotesToGames < ActiveRecord::Migration
  def change
    add_column :games, :notes, :string
  end
end
