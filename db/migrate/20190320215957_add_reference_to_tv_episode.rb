class AddReferenceToTvEpisode < ActiveRecord::Migration[5.2]
  def change
    add_reference :tv_episodes, :tv, foreign_key: true
  end
end
