class PrivateTrip < ApplicationRecord
    has_one_attached :picture
    has_rich_text :name_fr
    has_rich_text :name_en
    has_rich_text :description_fr
    has_rich_text :description_en

    validates :picture, :name_en, :name_fr, :description_fr, :description_en, presence: true
    validates_length_of :description_en, maximum: 300
    validates_length_of :description_fr, maximum: 300
    validates_length_of :name_en, maximum: 50
    validates_length_of :name_fr, maximum: 50

    def name
        self.send("name_#{I18n.locale}")
    end

    def description
        self.send("description_#{I18n.locale}")
    end
end
