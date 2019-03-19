class TvLastEpisodeToAir < ApplicationRecord
  belongs_to :tv
  belongs_to :tv_episode
end
