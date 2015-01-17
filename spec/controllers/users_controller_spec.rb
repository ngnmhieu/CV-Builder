require 'rails_helper'

describe UsersController, :type => :controller do
  # describe "User Login" do
    # let(:params) { { email: "test@eat.chocolate", password: "eat" } }
    # let(:test_user) { double('user', id: 10, name: 'test', email: 'test@eat.chocolate', password: '1234') }

    # it "should authenticate user" do
      # expect(User).to receive(:authenticate).with(params[:email], params[:password])
      # post :authenticate, { user: params }
    # end

    # it "should return to homepage when login succeed" do
      # assume authentication succeeds
      # allow(User).to receive(:authenticate) { test_user }
      # post :authenticate, { user: params }

      # expect(response).to redirect_to(root_path)
    # end

    # it "should return to login page when login fails" do
      # assume authentication fails
      # allow(User).to receive(:authenticate) { false }
      # post :authenticate, { user: params }

      # expect(response).to redirect_to(login_path)
    # end

    # it "should return to homepage if user already logged in" do
      # allow(controller).to receive(:logged_in?) { true }
      # get :login 

      # expect(response).to redirect_to(root_path)
    # end
    
  # end

  # describe "User Logout" do
    # it "should return to hompage after logging out" do
    #   post :logout

    #   expect(response).to redirect_to(root_path)
    # end
  # end

  # describe "User Registration" do
    # let(:test_user) { double('user', id: 10, name: 'test', email: 'test@eat.chocolate', password: '1234') }
    # let(:register_params) { { user: { email: test_user.email, password: test_user.password } } }

    # it "should save new user" do
    #   allow(User).to receive(:new) { test_user }
    #   expect(test_user).to receive(:save)

    #   post :create, register_params
    # end

    # it "should return to homepage on success" do
    #   allow(User).to receive(:new) { test_user }
    #   allow(test_user).to receive(:save) { true }

    #   post :create, register_params

    #   expect(response).to redirect_to(root_path) 
    # end

    # it "should return to registration page on failure" do
    #   allow(User).to receive(:new) { test_user }
    #   allow(test_user).to receive(:save) { false }

    #   post :create, register_params 

    #   expect(response).to render_template(:register) 
    # end
  # end

end
