class Theme < ApplicationRecord
    has_and_belongs_to_many :trips

    validates :name, presence: true
    validates_uniqueness_of :name_fr
    validates_uniqueness_of :name_en

    def titleize_name
        self.name_fr = self.name_fr.titleize
        self.name_en = self.name_en.titleize
    end

    def name
        self.send("name_#{I18n.locale}")
    end
end
