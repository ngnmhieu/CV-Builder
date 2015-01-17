require 'rails_helper'

describe SessionsController, type: :controller do
  context "Authentication with Default Identity" do
    describe "User Login (POST #auth_default_identity)" do
      let(:user) { create(:user_default_identity) }
      let(:identity) { user.default_identity }
      let(:identity_params) { { default_identity: attributes_for(:default_identity) } }

      it "should authenticate user with email password" do
        expect(DefaultIdentity).to receive(:authenticate)

        post :auth_default_identity, identity_params
      end

      it "should redirect to homepage if authentication succeeds" do
        # assume authentication succeeds
        allow(DefaultIdentity).to receive(:authenticate) { identity }

        post :auth_default_identity, identity_params

        expect(response).to redirect_to(root_path)
      end

      it "should redirect to login page if authentication fails" do
        # assume authentication fails
        allow(DefaultIdentity).to receive(:authenticate) { false }

        post :auth_default_identity, identity_params

        expect(response).to redirect_to(login_path)
      end

      # it "should redirect to homepage if user already logged in"
    end

    describe "User Logout" do
      it "should redirect to hompage after logging out (GET #destroy)" do
        get :destroy
        expect(response).to redirect_to(root_path)
      end
    end

    describe "User Registration (POST #create)" do
      let(:register_params) { { default_identity: attributes_for(:default_identity) } }
      let(:test_user) { build(:user_default_identity) }

      it "should log new user in after registration" do
        allow_any_instance_of(User).to receive(:save) { true }
        allow_any_instance_of(DefaultIdentity).to receive(:save) { true }
        expect(@controller).to receive(:do_login)

        post :create, register_params
      end

      it "should create a new identity along with a new user" do
        expect {
          post :create, register_params
        }.to change(User, :count).by(1).and change(DefaultIdentity, :count).by(1)
      end

      it "should redirect to homepage if registration succeeds" do
        allow_any_instance_of(User).to receive(:save) { true }
        allow_any_instance_of(DefaultIdentity).to receive(:save) { true }

        post :create, register_params

        expect(response).to redirect_to(root_path)
      end

      it "should render :register view if registration fails" do
        allow_any_instance_of(User).to receive(:save) { false }
        allow_any_instance_of(DefaultIdentity).to receive(:save) { false }

        post :create, register_params

        expect(response).to render_template(:register)
      end

    end
  end

  context "Authentication with OpenID" do
    # setup the test data from oauth providers
    let(:default_auth) { { provider: 'default', uid: '123456789' } }
    let(:facebook_auth) { { provider: 'facebook', uid: '123456789' } }
    let(:twitter_auth) { { provider: 'twitter', uid: '123456789' } }
    let(:auth_info) { { name: "Awesome User", email: "awesome@email.org" } }

    before(:all) do
      auth_info = {
        name: "Awesome User",
        email: "awesome@email.org"
      }
      default_auth = { provider: 'default', uid: '123456789', info: auth_info }
      facebook_auth = { provider: 'facebook', uid: '123456789', info: auth_info }
      twitter_auth = { provider: 'twitter', uid: '123456789', info: auth_info }

      OmniAuth.config.test_mode = true
      OmniAuth.config.add_mock(:default, default_auth)
      OmniAuth.config.add_mock(:facebook, facebook_auth)
      OmniAuth.config.add_mock(:twitter, twitter_auth)
    end

    before(:each) do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:default]
    end

    describe "User Login GET #auth_openid " do
      it "should authenticate user with uid and provider" do
        expect(OauthIdentity).to receive(:authenticate).with(default_auth[:uid], default_auth[:provider])
        get :auth_openid, provider: :default 
      end

      it "should create new user and identity if not existed yet" do
        user = build(:user)
        allow(OauthIdentity).to receive(:authenticate) { nil }
        expect(User).to receive(:new) { user }

        get :auth_openid, provider: :default
      end
      
      it "should redirect to homepage if authentication succeeds" do
        user = create(:user_oauth)
        allow(OauthIdentity).to receive(:authenticate) { user.oauth_identities.first }

        get :auth_openid, provider: :default
        expect(response).to redirect_to(root_path)
      end

      it "should log user in after authentication" do
        user = create(:user_oauth)
        allow(OauthIdentity).to receive(:authenticate) { user.oauth_identities.first }

        expect(@controller).to receive(:do_login).with(user.id)

        get :auth_openid, provider: :default
      end

      it "should create new user with name and email" do
        allow(OauthIdentity).to receive(:authenticate) { nil }
        new_user = build(:user)
        expect(User).to receive(:new).with(auth_info) { new_user }

        get :auth_openid, provider: :default
      end
    end

    # describe "User Login Cancel GET #auth_openid_cancel"
  end
end
