desc 'my orders email'
task my_orders_email: :environment do
    @orders = Order.all
    UserMailer.my_orders_email(@orders).deliver!
end