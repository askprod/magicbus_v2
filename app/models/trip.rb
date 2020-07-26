class Trip < ApplicationRecord
    NUMBER_OF_PERMITTED_TRAVELLERS = 8

    belongs_to :season
    has_one_attached :picture
    has_and_belongs_to_many :themes
    has_many :cart_trips
    has_many :carts, through: :cart_trips
    has_many :order_trips, dependent: :destroy
    has_many :orders, through: :order_trips
    has_rich_text :name_fr
    has_rich_text :name_en
    has_rich_text :description_fr
    has_rich_text :description_en

    validate :valid_departure_arrival_dates, on: :create
    validates :picture, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..3.megabytes }
    validates :price, :themes,  :arrival_date, :departure_date, :departure_location, :arrival_location, :week, :picture, :name_fr, :name_en, :description_fr, :description_en, presence: true 
    validates_uniqueness_of :week, scope: :season

    def remaining_seats_count
        traveller_in_orders = Order.joins(:trips).where(trips: {id: self.id}).map{|order| order.travellers.count}.sum
        traveller_in_carts = Cart.joins(:trips).where(trips: {id: self.id}).map{|cart| cart.travellers.count}.sum
        total = traveller_in_carts + traveller_in_orders
        return NUMBER_OF_PERMITTED_TRAVELLERS - total
    end

    def description
        self.send("description_#{I18n.locale}")
    end

    def name
        self.send("name_#{I18n.locale}")
    end

    def valid_departure_arrival_dates
        if arrival_date < departure_date
            errors.add(:end_date, "must be after the start date")
        end
    end

    def is_full?
        self.remaining_seats_count <= 0
    end

    def is_bookable?
        self.departure_date > (Date.today - 2.days)
    end
end
