class AddDetailToGenres < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :name, :string
    add_column :genres, :type, :decimal
  end
end
