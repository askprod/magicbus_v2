class Trip < ApplicationRecord
    belongs_to :journey
    has_one_attached :picture
    has_and_belongs_to_many :themes
    # has_many :trip_travellers
    # has_many :travellers, through: :trip_travellers
    has_many :cart_trips
    has_many :carts, through: :cart_trips

    validates :picture, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..3.megabytes }
    validates :price, :themes,  :arrival_date, :departure_date, :departure_city, :arrival_city, :name, :description, :week, :meetup_time, :departure_address, :arrival_address, :picture, presence: true 
    validates_uniqueness_of :week, scope: :journey
end
