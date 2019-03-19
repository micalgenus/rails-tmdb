class CreateTvLastEpisodeToAirs < ActiveRecord::Migration[5.2]
  def change
    create_table :tv_last_episode_to_airs do |t|
      t.references :tv, foreign_key: true
      t.references :tv_episode, foreign_key: true

      t.timestamps
    end
  end
end
