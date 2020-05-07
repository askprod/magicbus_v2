class DietTraveller < ApplicationRecord
    belongs_to :traveller
    belongs_to :food_diet
end
