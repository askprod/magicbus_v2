class TripTraveller < ApplicationRecord
    belongs_to :trip
    belongs_to :traveller
end
