class OauthIdentity < ActiveRecord::Base
  belongs_to :user

  def self.authenticate(uid, provider)
  end
end
