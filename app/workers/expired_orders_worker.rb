class ExpiredOrdersWorker
  include Sidekiq::Worker

  def perform(*args)
    stars = "*" * 10
    orders_to_empty = Order.where("expires_at <=?", Time.now - 1.day)
    orders = Order.all

    puts stars
    puts "Deleting Expired Orders (until #{Time.now - 1.day}):"
    puts stars

    orders.each do |order|
      order.trips.each do |trip|
        if trip.is_expired? || trip.is_blocked?
          order.destroy
          puts stars
          puts "Deleted Order##{order.id}, Name: #{order.name}, because a trip in the order was not valid anymore."
          puts stars
        end
      end
    end

    if  orders_to_empty.any?
        orders_to_empty.each do |order|
            order.destroy
            puts stars
            puts "Deleted Order##{order.id}, Name: #{order.name}."
            puts stars
        end
    else
        puts stars
        puts "No Order found."
        puts stars
    end

    puts stars
    puts "Done clearing Orders."
    puts stars
  end
end
