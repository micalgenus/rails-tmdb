class CreateMovieCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_countries do |t|
      t.references :movie, foreign_key: true
      t.references :country, foreign_key: true

      t.timestamps
    end
  end
end
