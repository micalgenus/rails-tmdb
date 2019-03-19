class AddDetailToMovieCasts < ActiveRecord::Migration[5.2]
  def change
    add_column :movie_casts, :character, :string
    add_column :movie_casts, :order, :decimal
  end
end
