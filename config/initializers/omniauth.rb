Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['APP.FACEBOOK_KEY'], ENV['APP.FACEBOOK_SECRET']
  provider :twitter, ENV['APP.TWITTER_KEY'], ENV['APP.TWITTER_SECRET']
  provider :linkedin, ENV['APP.LINKEDIN_KEY'], ENV['APP.LINKEDIN_SECRET']
  provider :google_oauth2, ENV['APP.GOOGLEPLUS_KEY'], ENV['APP.GOOGLEPLUS_SECRET']
end
