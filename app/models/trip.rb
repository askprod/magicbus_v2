class Trip < ApplicationRecord
    belongs_to :journey
    has_one_attached :picture
    has_and_belongs_to_many :themes
    has_many :cart_trips
    has_many :carts, through: :cart_trips

    validates :picture, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..3.megabytes }
    validates :price, :themes,  :arrival_date, :departure_date, :departure_location, :arrival_location, :name, :description, :week, :meetup_time, :picture, presence: true 
    validates_uniqueness_of :week, scope: :journey

    def remaining_seats_count
        # Array = the number of travellers in each cart containing our trip id
        traveller_in_carts = Cart.joins(:trips).where(trips: {id: self.id}).map{|cart| cart.travellers.count}.sum
        return 8 - traveller_in_carts
    end
end
