class RestrictionTraveller < ApplicationRecord
    belongs_to :traveller
    belongs_to :food_restriction

    accepts_nested_attributes_for :food_restriction, :reject_if => :all_blank
end
