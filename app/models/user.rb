class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, :omniauth_providers => [:twitter, :google_oauth2]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :username, :login, :provider,
                  :name, :uid, :avatar, :profile_type, :profile_type_id
  # attr_accessible :title, :body

  attr_accessor :login

  # Relations
  has_many :channels, :dependent => :destroy
  belongs_to :profile_type
  has_many :comments, :dependent => :destroy

  # Paperclip
  has_attached_file :avatar, :styles => { :large => "400x400", :medium => "200x200>", :thumb => "100x100>" }

  # Validations
  validates :first_name, :last_name, :username, :presence => true, :length => { :maximum => 50 }
  validates :username, :uniqueness => true

  before_create :assign_profile_type

  # Devise custon lookup by login or email for authentication
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  # Fetch all user articles
  def all_articles
    Article.where(:channel_id => self.channel_ids)
  end

  # Fetch starred articles
  def starred_articles
    Article.where(:channel_id => self.channel_ids, :starred => true)
  end

  def articles_count
    all_articles.size
  end

  def starred_articles_count
    starred_articles.size
  end

  # Twitter authentication with omniauth
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(first_name:auth.info.name.split(' ').first,
                         last_name:auth.info.name.split(' ').last,
                         username:auth.info.nickname,
                         provider:auth.provider,
                         uid:auth.uid,
                         password:Devise.friendly_token[0,20]
                         )
      user.confirm!
    end
    user
  end

  def self.find_for_google_oauth2(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(first_name:auth.info.first_name,
                         last_name:auth.info.last_name,
                         username:(auth.info.first_name + auth.info.last_name),
                         provider:auth.provider,
                         email:auth.info.email,
                         uid:auth.uid,
                         password:Devise.friendly_token[0,20]
                         )
      user.confirm!
    end
    user
  end


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      elsif data = session["devise.google_data"] && session["devise.google_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def email_required?
    super && provider.blank?
  end

  def channel_limit
    self.profile_type.channel_limit
  end

  private
  def assign_profile_type
    self.profile_type = ProfileType.default_profile
  end
end
