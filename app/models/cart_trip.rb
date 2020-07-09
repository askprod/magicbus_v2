class CartTrip < ApplicationRecord
    belongs_to :cart, touch: true
    belongs_to :trip

    validates_uniqueness_of :trip_id, :scope => :cart_id, :message => "is already in your cart"
end
