class AddForeignkeyToMovieGenres < ActiveRecord::Migration[5.2]
  def change
    add_reference :movie_genres, :movie, foreign_key: true
    add_reference :movie_genres, :genre, foreign_key: true
  end
end
