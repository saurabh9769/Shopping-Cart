class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :confirmable,
				 :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

	has_many :user_addresses
	has_many :orders
	has_many :user_wish_lists
	has_many :products, through: :user_wish_lists
	validates :email, presence: true
	validates :encrypted_password, presence: true

	scope :users_registered, -> { (group("date_trunc('month', created_at)").order("date_trunc('month', created_at) ASC")) }

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.email = auth.info.email
			user.password = Devise.friendly_token[0,20]
		end
	end

	def self.new_with_session(params, session)
		super.tap do |user|
			if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
				user.email = data["email"] if user.email.blank?
			elsif data = session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
				user.email = data["email"] if user.email.blank?
			end
		end
	end

end
