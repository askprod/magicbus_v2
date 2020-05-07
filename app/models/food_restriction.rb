class FoodRestriction < ApplicationRecord
    has_many :restriction_travellers
    has_many :travellers, through: :restriction_travellers

    before_save :titleize_name

    def titleize_name
        self.name = self.name.titleize
    end
end
