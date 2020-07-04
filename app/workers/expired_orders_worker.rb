class ExpiredOrdersWorker
  include Sidekiq::Worker

  def perform(*args)
    stars = "*" * 10
    orders_to_empty = Order.where("expires_at <=?", Time.now - 1.day)

    puts stars
    puts "Deleting Expired Orders (until #{Time.now - 1.day}):"
    puts stars

    if  orders_to_empty.any?
        orders_to_empty.each do |order|
            order.destroy
            puts "*" * 10
            puts "Deleted Order##{order.id}, Name: #{order.name}."
            puts "*" * 10
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
