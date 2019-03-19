class CreateTvSeasons < ActiveRecord::Migration[5.2]
  def change
    create_table :tv_seasons do |t|

      t.timestamps
    end
  end
end
