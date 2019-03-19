class AddDetailToTvSeasons < ActiveRecord::Migration[5.2]
  def change
    add_column :tv_seasons, :_id, :string
    add_column :tv_seasons, :air_date, :date
    add_column :tv_seasons, :name, :string
    add_column :tv_seasons, :overview, :text
    add_column :tv_seasons, :poster_path, :string
    add_column :tv_seasons, :season_number, :decimal
  end
end
