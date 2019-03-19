class CreateMovieCasts < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_casts do |t|

      t.timestamps
    end
  end
end
