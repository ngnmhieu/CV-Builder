require 'rails_helper'

describe UsersController, :type => :controller do
  describe "User login" do
    let(:params) { { email: "test@chocolate.sweet", password: "eat" } }

    it "should authenticate user" do
      expect(User).to receive(:authenticate).with(params[:email], params[:password])
      post :authenticate, { user: params }
    end

    it "should return to homepage when login succeed" do
      user = double('user', id: 10, name: 'test', email: 'test@eat.chocolate')
      # assume authenticate successfull
      allow(User).to receive(:authenticate) { user }
      post :authenticate, { user: params }

      expect(response).to redirect_to(root_path)
    end

    it "should return to login page when login fails" do
      allow(User).to receive(:authenticate) { false }
      post :authenticate, { user: params }

      expect(response).to redirect_to(login_path)
    end

  end
end
