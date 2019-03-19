class AddDetailToTvEpisodes < ActiveRecord::Migration[5.2]
  def change
    add_column :tv_episodes, :air_date, :date
    add_column :tv_episodes, :episode_number, :decimal
    add_column :tv_episodes, :name, :string
    add_column :tv_episodes, :overview, :text
    add_column :tv_episodes, :production_code, :string
    add_column :tv_episodes, :season_number, :decimal
    add_column :tv_episodes, :still_path, :string
    add_column :tv_episodes, :vote_average, :float
    add_column :tv_episodes, :vote_count, :decimal
  end
end
