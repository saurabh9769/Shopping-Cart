class CouponsUsed < ActiveRecord::Base

	has_many :coupons

	scope :total_coupons, -> { (group("date_trunc('month', created_at)").order("date_trunc('month', created_at) ASC")) }
end
