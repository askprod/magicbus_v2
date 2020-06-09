class FoodDiet < ApplicationRecord
    has_many :diet_travellers
    has_many :travellers, through: :diet_travellers

    def name
        self.send("name_#{I18n.locale}")
    end
end
