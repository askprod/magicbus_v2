class Place < ApplicationRecord
    has_one_attached :image_one
    has_one_attached :image_two
    has_one_attached :image_three
    belongs_to :user, optional: true

    validates_presence_of :name, :description, unless: :secret_is_true?
    validates_presence_of :longitude, :latitude
    validates :image_one, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..1.megabytes }
    validates :image_two, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..1.megabytes }
    validates :image_three, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..1.megabytes }
    validate :longitude_latitude_closeness, on: [:create]
    validate :spot_limit, on: [:create]

    before_save :capitalize_attributes

    def spot_limit
        if User.find(self.user.id).places.count >= 10
            self.errors.add(:base, "You can't share more than 10 spots for now.")
        end
    end
    
    def longitude_latitude_closeness
        existing_latitudes = Place.all.pluck(:latitude)
        existing_longitudes = Place.all.pluck(:longitude)
        new_latitude = self.latitude.round(4)
        new_longitude = self.longitude.round(4)

        check_latitudes = existing_latitudes.map{|v| v.round(4) == new_latitude}.include?(true)
        check_longitudes = existing_longitudes.map{|v| v.round(4) == new_longitude}.include?(true)

        if check_longitudes == true && check_latitudes == true
            self.errors.add(:base, "A Spot has already been shared here. Try another location.")
        end
    end

    def secret_is_true?
        self.secret_status == true
    end

    def capitalize_attributes
        if self.name 
            self.name = name.titleize
            self.description = capitalize_sentences(description)
        end
    end

    def capitalize_sentences(string)
        unless string.blank?
          string.split(/(?<=[?.!])/).map(&:capitalize).join(" ")
        end
    end
end
