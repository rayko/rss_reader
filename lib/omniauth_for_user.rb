module OmniauthForUser
  module ClassMethods
    # Twitter authentication with omniauth
    def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
      user = User.where(:provider => auth.provider, :uid => auth.uid).first
      unless user
        # params: auth, first name, last name, username
        user = create_and_confirm_user(auth, get_twitter_first_name(auth.info.name), get_twitter_last_name(auth.info.name), auth.info.nickname)
      end
      user
    end

    def self.find_for_google_oauth2(auth, signed_in_resource=nil)
      user = User.where(:provider => auth.provider, :uid => auth.uid).first
      unless user
        # params: auth, first name, last name, username
        user = create_and_confirm_user(auth, auth.info.first_name, auth.info.last_name, get_google_username(auth.info.nickname))
      end
      user
    end

    # Twitter authentication with omniauth
    def self.new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        elsif data = session["devise.google_data"] && session["devise.google_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end

  end

  def self.included(base)
    base.extend ClassMethods
  end

  def email_required?
    super && provider.blank?
  end

  private
  def get_twitter_first_name name
    name.split(' ').first
  end

  def get_twitter_last_name name
    name.split(' ').last
  end

  def get_google_username name
    name.join('')
  end

  def create_and_confirm_user auth, first_name, last_name, username
    user = User.create(:first_name => first_name,
                       :last_name => last_name,
                       :username => username,
                       :provider => auth.provider,
                       :email => auth.info.email,
                       :uid => auth.uid,
                       :password => Devise.friendly_token[0,20]
                       )
    user.confirm!
    return user
  end
end
