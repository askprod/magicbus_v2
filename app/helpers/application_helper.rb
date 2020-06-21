module ApplicationHelper
    def active_season
        Season.find_by(status: true).present?
    end    

    def departure_city(trip)
        trip.departure_location['locality']
    end

    def arrival_city(trip)
        trip.arrival_location['locality']
    end

    def departure_country(trip)
        trip.departure_location['country']
    end

    def arrival_country(trip)
        trip.arrival_location['country']
    end

    def latlng_departure_location(trip)
        trip.departure_location['location']
    end

    def latlng_arrival_location(trip)
        trip.arrival_location['location']
    end

    def find_country_code(country)
        result = ISO3166::Country.find_country_by_name(country).alpha2
    end
    
    def find_trip_id(x)
        Trip.find(x.trip_id)
    end

    def find_trip_id_foreign_key(x)
        Trip.find(x.trip_id).id
    end
end
