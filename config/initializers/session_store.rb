# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

unless (secret = CONFIG[:session_secret])
	secret_file = File.join(Rails.root, "config/session_secret")
	if File.exist?(secret_file)
		secret = File.read(secret_file)
	else
		secret = ActiveSupport::SecureRandom.hex(64)
		File.open(secret_file, 'w') { |f| f.write(secret) }
	end
end

ActionController::Base.session = {
  :key          => CONFIG[:session_key] || '_quails_session',
  :secret       => secret,
  :expires      => 3.years.from_now
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
