# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
            email:"admin@magicbus.com", 
            password:"adminpassword123*", 
            terms_and_conditions: true, admin: true
            )

Journey.create!(status: true)

themes = ["Mountain", "Sea", "Coast", "Forest", "Woodland", "Jungle"]

themes.each do |theme_name|
    Theme.create!(name: theme_name)
end
