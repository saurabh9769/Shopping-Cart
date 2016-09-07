class Banner < ActiveRecord::Base

	belongs_to :admin
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

	# validates :text, presence: true
end
