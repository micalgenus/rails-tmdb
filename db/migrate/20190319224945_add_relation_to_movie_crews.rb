class AddRelationToMovieCrews < ActiveRecord::Migration[5.2]
  def change
    add_reference :movie_crews, :movie, foreign_key: true
    add_reference :movie_crews, :person, foreign_key: true
  end
end
