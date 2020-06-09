class FoodRestriction < ApplicationRecord
    has_many :restriction_travellers
    has_many :travellers, through: :restriction_travellers

    def name
        self.send("name_#{I18n.locale}")
    end
end
