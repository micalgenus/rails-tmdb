class Person < ApplicationRecord
  has_many :movie_cast
  has_many :movie_crew

  has_many :person_as_name
end
