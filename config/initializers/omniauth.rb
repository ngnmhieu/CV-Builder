Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['APP.FACEBOOK_KEY'], ENV['APP.FACEBOOK_SECRET']
end
