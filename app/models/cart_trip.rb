class CartTrip < ApplicationRecord
    belongs_to :cart
    belongs_to :trip
end
