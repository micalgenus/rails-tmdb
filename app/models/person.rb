class Person < ApplicationRecord
  has_many :movie_cast
  has_many :movie_crew
end
