Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  config.action_mailer.perform_deliveries = true


  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  config.action_mailer.default_url_options = { host: 'localhost:3000'}
  ENV['FACEBOOK_APP_ID'] = '139185996528544';
  ENV['FACEBOOK_SECRET'] = '964136c8422b721d086a03c49e14aa49';
  ENV['TWITTER_KEY'] = "l26r74acbdmvMSfPebDh0YkPE";
  ENV['TWITTER_SECRET'] = "sUt7LOIoDmqoXgF9lAA9KMbN6MkPdmVB5aaSJWTMqrdjI0qBy3";
  ENV['MAILCHIMP-API-KEY'] = "01ed8fa9a2a46bed75f1bcdc83222782-us14"


  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.delivery_method = :sendmail
  # ActionMailer::Base.delivery_method = :sendmail
  # config.action_mailer.sendmail_settings = {
  #   # address: "smtp.wwindia.com",
  #   # user_name: ENV["saurabh.sangani@wwindia.com"],
  #   # password: ENV["saurabhs123"],
  #   # ssl: true,
  #   # openssl_verify_mode: 'none'
  #   location: '/usr/sbin/sendmail',
  #   arguments: '-i -t',
  #   enable_starttls_auto: true
  # }
end
