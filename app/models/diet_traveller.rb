class DietTraveller < ApplicationRecord
    belongs_to :traveller
    belongs_to :food_diet

    accepts_nested_attributes_for :food_diet, :reject_if => :all_blank
end
