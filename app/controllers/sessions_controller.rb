class SessionsController < ApplicationController

  # TODO: merge account

  # authenticate user with OpenID 
  def auth_openid
    auth = request.env['omniauth.auth']
    found_identity = OauthIdentity.authenticate(auth[:uid], auth[:provider])

    if found_identity
      user = found_identity.user
      result = !user.nil? # does user exists?
    else
      user = User.new(name: auth[:info][:name])
      user.email = auth[:info][:email] if auth[:info][:email]
      identity = user.oauth_identities.build(uid: auth[:uid], provider: auth[:provider])
      if user.valid? && identity.valid? 
        result = user.save && identity.save
      else
        result = false
      end
    end

    if result
      respond_to do |format|
        do_login(user.id)
        format.html { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.html do
          flash[:warning] = "Sorry, we couldn't log you in at the moment, please try login with another provider or try again later."
          redirect_to login_path 
        end
      end
    end
  end

  def auth_openid_cancel
    respond_to do |format|
      format.html do
        flash[:warning] = "Sorry, we couldn't log you in at the moment, please login eith another provider or try again later."
        redirect_to login_path
      end
    end
  end

  # display registration page
  def register
    @identity = DefaultIdentity.new
  end

  # display login page
  def login
    @identity = DefaultIdentity.new
  end

  # receive registration data
  def create
    @user = User.new(email: register_params[:email])
    @identity = @user.build_default_identity(register_params)

    save_result = @identity.save && @user.save

    if save_result
      do_login(@user.id)
      respond_to do |format|
        format.html { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.html { render :register }
      end
    end
  end

  # receive authentication data
  def auth_default_identity
    identity = DefaultIdentity.authenticate(login_params[:email], login_params[:password])

    if identity
      do_login(identity.user.id)
      respond_to do |format|
        format.html { redirect_to root_path }
      end
    else 
      respond_to do |format|
        format.html do
          flash[:warning] = "Sorry, we cannot log you in. You might have given the wrong email/password. Please try again."
          redirect_to login_path
        end
      end
    end
  end

  # logout
  def destroy
    session[:user_id] = nil
    respond_to do |format| 
      format.html { redirect_to root_path } 
    end
  end

  private 
    def do_login(user_id)
      session[:user_id] = user_id
    end

    def login_params
      params.require(:default_identity).permit(:email, :password)
    end

    def register_params
      params.require(:default_identity).permit(:email, :password, :password_confirmation)
    end
end
