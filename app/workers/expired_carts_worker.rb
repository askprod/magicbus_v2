class ExpiredCartsWorker
  include Sidekiq::Worker

  def perform(*args)
    stars = "*" * 10
    carts_to_empty = Cart.where("expires_at <=?", Time.now - 1.hour)
    carts = Cart.all

    puts stars
    puts "Emptying Expired Carts (until #{Time.now - 1.hour}):"
    puts stars

    carts.each do |cart|
      cart.trips.each do |trip|
        if trip.is_expired? || trip.is_blocked?
          cart.trips.delete(trip)
          puts stars
          puts "Cleared some trips from Cart#{cart.id}, Name: #{cart.name}, because they were not valid anymore."
          puts stars
        end
      end
    end

    if carts_to_empty.any?
        carts_to_empty.each do |cart|
            cart.clear_cart
            puts stars
            puts "Cleared Cart##{cart.id}, Name: #{cart.name}."
            puts stars
        end
    else
        puts stars
        puts "No Cart found."
        puts stars
    end

    puts stars
    puts "Done clearing Carts."
    puts stars
  end
end

