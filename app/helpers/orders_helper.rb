module OrdersHelper
  # binding.pry
  # def orders_chart_series(orders, start_time)
  #   orders_by_day = orders.where(:created_at => start_time.beginning_of_day..Time.zone.now.end_of_day).
  #                   group("date(created_at)").
  #                   select("created_at, sum(grand_total) as total_price")
  #   (start_time.to_date..Date.today).map do |date|
  #     order = orders_by_day.detect { |order| order.created_at.to_date == date }
  #     order && order.grand_total.to_f || 0
  #   end.inspect
  # end
end
