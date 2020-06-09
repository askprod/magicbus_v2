module TravellersHelper
    def translated_nationality(traveller)
        id = traveller.nationality
        puts id
        file = JSON.parse(File.read("app/assets/json/nationalities_#{locale}.json"))
        value = file.find {|k, v| k == id }.last
        return value.to_s
    end
end
