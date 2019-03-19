class CreateTvEpisodeCrews < ActiveRecord::Migration[5.2]
  def change
    create_table :tv_episode_crews do |t|
      t.references :tv_episode, foreign_key: true
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
