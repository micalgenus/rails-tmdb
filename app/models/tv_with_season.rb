class TvWithSeason < ApplicationRecord
  belongs_to :tv
  belongs_to :tv_season
end
