require 'rails_helper'

describe SessionsController, type: :controller do
  describe "User Login with Default Identity " do
    let(:user) { create(:user) }
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
    it "should redirect to hompage after logging out" do
      get :destroy
      expect(response).to redirect_to(root_path)
    end
  end

  describe "User Registration" do
    let(:register_params) { { default_identity: attributes_for(:default_identity) } }
    let(:test_user) { build(:user) }
    
    # it "should log new user in after registration"
    
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
