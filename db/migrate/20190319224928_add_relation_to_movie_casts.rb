class AddRelationToMovieCasts < ActiveRecord::Migration[5.2]
  def change
    add_reference :movie_casts, :movie, foreign_key: true
    add_reference :movie_casts, :person, foreign_key: true
  end
end
