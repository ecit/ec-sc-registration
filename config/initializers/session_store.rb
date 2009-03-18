# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sc-registration_session',
  :secret      => '79a78ad1cdf40e4e53abc4cd226ed49aa96d75e3e34843bc40ef1fd6859d43cd9f498e22a9d1c8a3d4ae8f3c60b85747357e35cd16b3c4d3f052fa08d218bdfd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
