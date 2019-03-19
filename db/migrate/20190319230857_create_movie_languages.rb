class CreateMovieLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_languages do |t|
      t.references :movie, foreign_key: true
      t.references :language, foreign_key: true

      t.timestamps
    end
  end
end
