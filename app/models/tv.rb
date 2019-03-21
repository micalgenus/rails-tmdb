class Tv < ApplicationRecord
  has_many :tv_cast
  has_many :tv_crew
end
