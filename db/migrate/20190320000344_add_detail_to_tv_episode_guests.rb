class AddDetailToTvEpisodeGuests < ActiveRecord::Migration[5.2]
  def change
    add_column :tv_episode_guests, :character, :text
    add_column :tv_episode_guests, :order, :decimal
  end
end
