class Trip < ApplicationRecord
    NUMBER_OF_PERMITTED_TRAVELLERS = 8

    belongs_to :season
    has_one_attached :picture
    has_and_belongs_to_many :themes
    has_many :cart_trips
    has_many :carts, through: :cart_trips
    has_many :order_trips, dependent: :destroy
    has_many :orders, through: :order_trips

    validates :picture, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..3.megabytes }
    validates :price, :themes,  :arrival_date, :departure_date, :departure_location, :arrival_location, :name, :description, :week, :meetup_time, :picture, presence: true 
    validates_uniqueness_of :week, scope: :season

    def remaining_seats_count
        traveller_in_orders = Order.joins(:trips).where(trips: {id: self.id}).map{|order| order.travellers.count}.sum
        traveller_in_carts = Cart.joins(:trips).where(trips: {id: self.id}).map{|cart| cart.travellers.count}.sum
        total = traveller_in_carts + traveller_in_orders
        return NUMBER_OF_PERMITTED_TRAVELLERS - total
    end

    def is_full?
        self.remaining_seats_count <= 0
    end
end
