class CreateEpisodeRunTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :episode_run_times do |t|
      t.references :tv, foreign_key: true
      t.decimal :run_time

      t.timestamps
    end
  end
end
