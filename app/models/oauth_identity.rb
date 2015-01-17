class OauthIdentity < ActiveRecord::Base
  belongs_to :user

  def self.authenticate(uid, provider)
    OauthIdentity.where({uid: uid, provider: provider}).first
  end
end
