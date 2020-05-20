class Place < ApplicationRecord
    has_one_attached :image_one
    has_one_attached :image_two
    has_one_attached :image_three
    belongs_to :user, optional: true

    validates_presence_of :name, :description
    validates_presence_of :location
    validates :image_one, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..1.megabytes }
    validates :image_two, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..1.megabytes }
    validates :image_three, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..1.megabytes }
    validate :longitude_latitude_closeness, on: [:create]
    validate :spot_limit, on: [:create]

    before_save :capitalize_attributes

    def spot_limit
        unless self.is_a_visitor?
            if User.find(self.user.id).places.count >= 10
                self.errors.add(:base, "You can't share more than 10 Spots for now.")
            end
        else
            unless Place.where(user_id: nil).last.created_at < Time.now - 15.seconds
                self.errors.add(:base, "Visitors are limited to sharing Spots. Try again later.")
            end
        end
    end

    def is_a_visitor?
        !User.exists?(self.user_id)
    end
    
    def longitude_latitude_closeness
        existing_latitudes = Place.all.pluck(:location).map{|x| x['lat']}
        existing_longitudes = Place.all.pluck(:location).map{|x| x['lng']}
        new_latitude = self.location['lat'].round(4)
        new_longitude = self.location['lng'].round(4)

        check_latitudes = existing_latitudes.map{|v| v.round(4) == new_latitude}.include?(true)
        check_longitudes = existing_longitudes.map{|v| v.round(4) == new_longitude}.include?(true)

        if check_longitudes == true && check_latitudes == true
            self.errors.add(:base, "A Spot has already been shared here. Try another location.")
        end
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
