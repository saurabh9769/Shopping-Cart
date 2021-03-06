class Order < ActiveRecord::Base

	enum status: { Accepted: 0, In_Progress: 1, Shipped: 2, Delivered: 3 , Completed: 4, Cancelled: 5 }
	belongs_to :user
	has_many :order_details
	has_many :products, through: :order_details
	after_update :change_status

  scope :count_of_orders, -> { (group("date_trunc('month', created_at)").order("date_trunc('month', created_at) ASC")) }
  scope :grand_total, -> { select("date_trunc('month', created_at)").group("date_trunc('month', created_at)").order("date_trunc('month', created_at) ASC").sum("grand_total") }

	private

  def change_status
    if self.status_changed?
    	@order_id = self.id
      UserMailer.change_status_mail(user, self.status, @order_id).deliver_now
  	end
  end

end
