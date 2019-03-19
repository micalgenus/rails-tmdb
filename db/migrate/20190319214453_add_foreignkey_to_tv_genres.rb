class AddForeignkeyToTvGenres < ActiveRecord::Migration[5.2]
  def change
    add_reference :tv_genres, :tv, foreign_key: true
    add_reference :tv_genres, :genre, foreign_key: true
  end
end
