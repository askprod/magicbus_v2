class FoodRestriction < ApplicationRecord
    has_many :restriction_travellers
    has_many :travellers, through: :restriction_travellers

    before_save :add_attributes_to_locales

    def add_attributes_to_locales
        unless self.name_fr.present?
            name = self.name_en
            self.name_fr ||= name
        end
    end

    def name
        self.send("name_#{I18n.locale}")
    end
end
