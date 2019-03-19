class CreateTvEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :tv_episodes do |t|

      t.timestamps
    end
  end
end
