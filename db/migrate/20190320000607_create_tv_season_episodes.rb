class CreateTvSeasonEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :tv_season_episodes do |t|
      t.references :tv_season, foreign_key: true
      t.references :tv_episode, foreign_key: true

      t.timestamps
    end
  end
end
