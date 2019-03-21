class AddDetailToMovieCasts < ActiveRecord::Migration[5.2]
  def change
    add_column :movie_casts, :character, :text
    add_column :movie_casts, :order, :decimal
  end
end
