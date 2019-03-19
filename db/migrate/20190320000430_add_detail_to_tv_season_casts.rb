class AddDetailToTvSeasonCasts < ActiveRecord::Migration[5.2]
  def change
    add_column :tv_season_casts, :character, :string
    add_column :tv_season_casts, :order, :decimal
  end
end
