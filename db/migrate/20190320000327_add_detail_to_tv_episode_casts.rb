class AddDetailToTvEpisodeCasts < ActiveRecord::Migration[5.2]
  def change
    add_column :tv_episode_casts, :character, :string
    add_column :tv_episode_casts, :order, :decimal
  end
end
