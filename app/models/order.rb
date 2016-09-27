class Order < ActiveRecord::Base

	enum status: { active: 1 ,  inactive: 0 }

end
