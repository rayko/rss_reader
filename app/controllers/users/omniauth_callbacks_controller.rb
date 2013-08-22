class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"], current_user)
    verify_and_readirect 'Twitter'
  end

  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
    verify_and_readirect 'Google'
  end

  private
  def verify_and_readirect kind
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => kind) if is_navigational_format?
    else
      session["devise.#{kind.downcase}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
