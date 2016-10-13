class ContactUs < ActiveRecord::Base

	after_update :check_note_admin

	private
		def check_note_admin
		  if self.note_admin.present?
		  	@contact_us_id = id
		    UserMailer.check_note_admin_mail(email, note_admin, @contact_us_id).deliver_now
			end
		end

end
