class Category < ActiveRecord::Base

	enum status: { active: 1 ,  inactive: 0 }

  has_many :subcategories, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  belongs_to :category, class_name: "Category"

  has_many :products

  # validates :name, presence: true
  # validates :status, presence: true

end
