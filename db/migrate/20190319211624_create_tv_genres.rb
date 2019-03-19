class CreateTvGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :tv_genres do |t|

      t.timestamps
    end
  end
end
