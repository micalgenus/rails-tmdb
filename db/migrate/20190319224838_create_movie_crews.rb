class CreateMovieCrews < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_crews do |t|

      t.timestamps
    end
  end
end
