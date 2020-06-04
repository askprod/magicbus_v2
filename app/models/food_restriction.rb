class FoodRestriction < ApplicationRecord
    has_many :restriction_travellers
    has_many :travellers, through: :restriction_travellers

    before_save :titleize_name

    def titleize_name
        self.name_fr = self.name_fr.titleize
        self.name_en = self.name_en.titleize
    end

    def name
        self.send("name_#{I18n.locale}")
    end
end
