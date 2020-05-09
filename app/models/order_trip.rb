class OrderTrip < ApplicationRecord
    belongs_to :order
    belongs_to :trip
end
