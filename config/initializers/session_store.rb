# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rhea_session',
  :secret      => '34d6197758dbb740522644b18671def55c6e9bb0a187fb5251922f93a51fb605a89957c524249c7a2ae5287fb1b12727b872ae92f9d5baf3383cbf6c3c69eeb6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
