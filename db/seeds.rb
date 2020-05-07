# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

FoodRestriction.create!(name: "Other", approved_status: true)
FoodRestriction.create!(name: "Sesame", approved_status: true)
FoodRestriction.create!(name: "Lactose Intolerance", approved_status: true)
FoodRestriction.create!(name: "Peanuts", approved_status: true)
FoodRestriction.create!(name: "Diabetic", approved_status: true)
FoodRestriction.create!(name: "Gluten", approved_status: true)
FoodRestriction.create!(name: "Halal", approved_status: true)

FoodDiet.create!(name: "Other", approved_status: true)
FoodDiet.create!(name: "Vegan", approved_status: true)
FoodDiet.create!(name: "Vegetarian", approved_status: true)

themes = ["Mountain", "Sea", "Coast", "Forest", "Woodland", "Jungle"]

themes.each do |theme_name|
    Theme.create!(name: theme_name)
end

User.create!(
            email:"admin@magicbus.com", 
            password:"adminpassword123*", 
            terms_and_conditions: true, admin: true
            )

Journey.create!(status: true)

random_theme = Theme.all.shuffle.sample
trip = Trip.new(name: "Trip 1", description: "Trip 1 Description", arrival_location: {"country"=>"France", "locality"=>"Toulouse", "location"=>{"latitude"=>43.604652, "longitude"=>1.444209}, "political"=>"France", "formatted_address"=>"Toulouse, France", "administrative_area_level_1"=>"Occitanie", "administrative_area_level_2"=>"Haute-Garonne"}, departure_location: {"country"=>"France", "locality"=>"Paris", "location"=>{"latitude"=>48.85661400000001, "longitude"=>2.3522219}, "political"=>"France", "formatted_address"=>"Paris, France", "administrative_area_level_1"=>"Île-de-France", "administrative_area_level_2"=>"Arrondissement de Paris"}, departure_date: "2020-05-06", arrival_date: "2020-05-07", price: 1000, week: 1, meetup_time: "2000-01-01 13:25:00", journey_id: 1)
trip.themes << random_theme
trip.save(validate: false)
trip.picture.attach(io: File.open("public/images/travel1.jpeg"), filename: "travel1.jpeg")
