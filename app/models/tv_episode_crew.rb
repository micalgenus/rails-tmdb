class TvEpisodeCrew < ApplicationRecord
  belongs_to :tv_episode
  belongs_to :person
end
