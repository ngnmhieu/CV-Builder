require 'rails_helper'

describe OauthIdentity, type: :model do
  describe "::authentication" do
    it "should find the correct identity with uid and provider" do
      user = create(:user_oauth)
      identity = user.oauth_identities.first
      expect(OauthIdentity.authenticate(identity.uid, identity.provider)).to eq identity
    end

    it "should return nil with non-existed identity" do
      identity = {uid: 'strange_uid', provider: 'strange_provider'}
      expect(OauthIdentity.authenticate(identity[:uid], identity[:providea])).to be nil
    end
  end
end
