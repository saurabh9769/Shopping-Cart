class UserMailer < ApplicationMailer
  after_action :set_delivery_options,
               :set_business_headers

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/users/sign_in'
    # email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail(to: @user.email, subject: 'Welcome to My Awesome Site',
         cc: 'admin@shopoholics.com', subject: 'Welcome to My Awesome Site'
        )
  end


  def receive(email)
    page = Page.find_by(address: email.to.first)
    page.emails.create(
      subject: email.subject,
      body: email.body
    )

    if email.has_attachments?
      email.attachments.each do |attachment|
        page.attachments.create({
          file: attachment,
          description: email.subject
        })
      end
    end
  end

  def order_confirmation(user, order)
    @user = user
    @order = order
    order.each do |order_id|
      @products = order_id.products
    end
    mail(to: @user.email, subject: 'Order has been received',
         cc: 'admin@shopoholics.com'
        )
  end

  def contact_us_mail(user, contact_us)
    @user = user
    @contact_us = contact_us
    mail(to: @contact_us.email, subject: 'Request has been received',
         cc: 'admin@shopoholics.com'
        )
  end

  def change_status_mail(user, status, order_id)
    @user = user
    @status = status
    @order_id = order_id
    mail(to: @user.email, subject: 'Status Update For Your Order',
         cc: 'admin@shopoholics.com'
      )
  end

  def check_note_admin_mail(email, note_admin, contact_us_id)
    @email = email
    @note_admin = note_admin
    @contact_us_id = contact_us_id
    mail(to: @email, subject: 'Response from Admin',
         cc: 'admin@shopoholics.com'
        )
  end

  def my_orders_email(orders)
    @orders = orders
    mail(to: 'admin@shopoholics.com', subject: 'Orders for the day')
  end

  def my_wishlist_email(wishlist)
    @wishlist = wishlist
    mail(to: 'admin@shopoholics.com', subject: "User's Wishlist for the week")
  end

  def feedback_message(business, user)
    @business = business
    @user = user
    mail
  end

  def campaign_message(business, user)
    @business = business
    @user = user
  end

  private

    def set_delivery_options
      # You have access to the mail instance,
      # @business and @user instance variables here
      if @business && @business.has_sendmail_settings?
        mail.delivery_method.settings.merge!(@business.sendmail_settings)
      end
    end

    def set_business_headers
      if @business
        headers["X-SMTPAPI-CATEGORY"] = @business.code
      end
    end
end
