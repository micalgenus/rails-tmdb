class CreateTvWithSeasons < ActiveRecord::Migration[5.2]
  def change
    create_table :tv_with_seasons do |t|
      t.references :tv, foreign_key: true
      t.references :tv_season, foreign_key: true

      t.timestamps
    end
  end
end