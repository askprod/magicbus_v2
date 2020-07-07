# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

case Rails.env
when "development"

    FoodRestriction.create!(name_en: "Sesame", name_fr: "Sésame", approved_status: true)
    FoodRestriction.create!(name_en: "Lactose Intolerance", name_fr: "Intolérance au lactose", approved_status: true)
    FoodRestriction.create!(name_en: "Nuts", name_fr: "Fruits à coque", approved_status: true)
    FoodRestriction.create!(name_en: "Gluten", name_fr: "Gluten", approved_status: true)
    FoodRestriction.create!(name_en: "Halal", name_fr: "Halal", approved_status: true)
    
    FoodDiet.create!(name_en: "Vegan", name_fr: "Vegan", approved_status: true)
    FoodDiet.create!(name_en: "Vegetarian", name_fr: "Végétarien",  approved_status: true)
    
    Theme.create!(name_en: "Mountain", name_fr: "Montagne")
    Theme.create!(name_en: "Sea", name_fr: "Mer")
    Theme.create!(name_en: "Ocean", name_fr: "Océan")
    Theme.create!(name_en: "Coast", name_fr: "Côtes")
    Theme.create!(name_en: "Forest", name_fr: "Forêt")
    Theme.create!(name_en: "Woodland", name_fr: "Bois")
    Theme.create!(name_en: "Jungle", name_fr: "Jungle")

    admin = User.new(first_name: "Lilly", last_name: "Admin", email:"admin@magicbus.com", password:"adminpassword123*", terms_and_conditions: true, admin: true)
    admin.skip_confirmation!
    admin.save!

    5.times do |index|
        user = User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email:"mail#{index}@mail.com", password:"password", terms_and_conditions: true, admin: false)
        user.skip_confirmation!
        user.save!
    end

    Season.create!(status: true)
    
    random_theme = Theme.all.shuffle.sample

    trip1 = Trip.new(arrival_location: {"country"=>"France", "locality"=>"Toulouse", "location"=>{"latitude"=>43.604652, "longitude"=>1.444209}, "political"=>"France", "formatted_address"=>"Toulouse, France", "administrative_area_level_1"=>"Occitanie", "administrative_area_level_2"=>"Haute-Garonne"}, departure_location: {"country"=>"France", "locality"=>"Paris", "location"=>{"latitude"=>48.85661400000001, "longitude"=>2.3522219}, "political"=>"France", "formatted_address"=>"Paris, France", "administrative_area_level_1"=>"Île-de-France", "administrative_area_level_2"=>"Arrondissement de Paris"}, departure_date: "2020-05-06", arrival_date: "2020-05-07", price: 800, week: 1, season_id: 1)
    trip1.themes << random_theme
    trip1.save(validate: false)
    trip1.picture.attach(io: File.open("public/images/travel1.jpeg"), filename: "travel1.jpeg")
    
    trip2 = Trip.new(arrival_location: {"country"=>"France", "locality"=>"Nice", "location"=>{"latitude"=>43.7101728, "longitude"=>7.261953200000002}, "political"=>"France", "formatted_address"=>"Nice, France", "administrative_area_level_1"=>"Provence-Alpes-Côte d'Azur", "administrative_area_level_2"=>"Alpes-Maritimes"}, departure_location: {"country"=>"France", "locality"=>"Toulouse", "location"=>{"latitude"=>43.604652, "longitude"=>1.444209}, "political"=>"France", "formatted_address"=>"Toulouse, France", "administrative_area_level_1"=>"Occitanie", "administrative_area_level_2"=>"Haute-Garonne"}, departure_date: "2020-05-06", arrival_date: "2020-05-07", price: 700, week: 2, season_id: 1)
    trip2.themes << random_theme
    trip2.save(validate: false)
    trip2.picture.attach(io: File.open("public/images/travel2.jpeg"), filename: "travel2.jpeg")
    

when "production"

    admin = User.new(first_name: "Lilly", last_name: "Admin", email:"admin@magicbus.com", password:"adminpassword123*", terms_and_conditions: true, admin: true)
    admin.skip_confirmation!
    admin.save!

    Theme.create!(name_en: "Mountain", name_fr: "Montagne")
    Theme.create!(name_en: "Sea", name_fr: "Mer")
    Theme.create!(name_en: "Ocean", name_fr: "Océan")
    Theme.create!(name_en: "Coast", name_fr: "Côtes")
    Theme.create!(name_en: "Forest", name_fr: "Forêt")
    Theme.create!(name_en: "Woodland", name_fr: "Bois")
    Theme.create!(name_en: "Jungle", name_fr: "Jungle")

    FoodRestriction.create!(name_en: "Sesame", name_fr: "Sésame", approved_status: true)
    FoodRestriction.create!(name_en: "Lactose Intolerance", name_fr: "Intolérance au lactose", approved_status: true)
    FoodRestriction.create!(name_en: "Nuts", name_fr: "Fruits à coque", approved_status: true)
    FoodRestriction.create!(name_en: "Gluten", name_fr: "Gluten", approved_status: true)
    FoodRestriction.create!(name_en: "Halal", name_fr: "Halal", approved_status: true)
    
    FoodDiet.create!(name_en: "Vegan", name_fr: "Vegan", approved_status: true)
    FoodDiet.create!(name_en: "Vegetarian", name_fr: "Végétarien",  approved_status: true)
    
end
