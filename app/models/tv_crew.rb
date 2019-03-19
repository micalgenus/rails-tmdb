class TvCrew < ApplicationRecord
  belongs_to :tv
  belongs_to :person
end
