# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_objectbox_session',
  :secret      => '9679b4e90ace755815810e2fc5ba19d5f99a57265a4517ff79cf73b37ec055731c9b2f856e1251301105f9360fe3119692e1d2d01032e75ea02735072ed7b308'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
