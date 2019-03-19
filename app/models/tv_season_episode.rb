class TvSeasonEpisode < ApplicationRecord
  belongs_to :tv_season
  belongs_to :tv_episode
end
