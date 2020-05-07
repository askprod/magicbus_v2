class RestrictionTraveller < ApplicationRecord
    belongs_to :traveller
    belongs_to :food_restriction
end
