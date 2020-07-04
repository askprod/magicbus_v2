class ExpiredCartsWorker
  include Sidekiq::Worker

  def perform(*args)
    stars = "*" * 10
    carts_to_empty = Cart.where("expires_at <=?", Time.now - 1.hour)

    puts stars
    puts "Emptying Expired Carts (until #{Time.now - 1.hour}):"
    puts stars

    if  carts_to_empty.any?
        carts_to_empty.each do |cart|
            cart.clear_cart
            puts "*" * 10
            puts "Cleared Cart##{cart.id}, Name: #{cart.name}."
            puts "*" * 10
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

