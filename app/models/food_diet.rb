class FoodDiet < ApplicationRecord
    has_many :diet_travellers
    has_many :travellers, through: :diet_travellers

    before_save :titleize_name

    def titleize_name
        self.name = self.name.titleize
    end
end
