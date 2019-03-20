class MovieCompany < ApplicationRecord
  belongs_to :movie
  belongs_to :company
end
