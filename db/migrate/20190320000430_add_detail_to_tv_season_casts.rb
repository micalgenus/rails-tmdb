class AddDetailToTvSeasonCasts < ActiveRecord::Migration[5.2]
  def change
    add_column :tv_season_casts, :character, :text
    add_column :tv_season_casts, :order, :decimal
  end
end
