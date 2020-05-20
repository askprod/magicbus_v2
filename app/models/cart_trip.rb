class CartTrip < ApplicationRecord
    belongs_to :cart, touch: true
    belongs_to :trip
end
