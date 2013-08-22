module OmniauthForUser
  module ClassMethods
    # Twitter authentication with omniauth
    def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
      user = User.where(:provider => auth.provider, :uid => auth.uid).first
      unless user
        user = User.create(:first_name => get_twitter_first_name(auth.info.name),
                           :last_name => get_twitter_last_name(auth.info.name),
                           :username => auth.info.nickname,
                           :provider => auth.provider,
                           :uid => auth.uid,
                           :password => Devise.friendly_token[0,20]
                           )
        user.confirm!
      end
      user
    end

    def self.find_for_google_oauth2(auth, signed_in_resource=nil)
      user = User.where(:provider => auth.provider, :uid => auth.uid).first
      unless user
        user = User.create(:first_name => auth.info.first_name,
                           :last_name => auth.info.last_name,
                           :username => get_google_username(auth.info.name),
                           :provider => auth.provider,
                           :email => auth.info.email,
                           :uid => auth.uid,
                           :password => Devise.friendly_token[0,20]
                           )
        user.confirm!
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
end
