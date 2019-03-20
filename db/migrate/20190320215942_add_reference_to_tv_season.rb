class AddReferenceToTvSeason < ActiveRecord::Migration[5.2]
  def change
    add_reference :tv_seasons, :tv, foreign_key: true
  end
end
