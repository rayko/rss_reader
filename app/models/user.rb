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

  require 'omniauth_for_user'
  require 'authentication_by_login'
  extend AuthenticationByLogin
  include OmniauthForUser

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

  def channel_limit
    self.profile_type.channel_limit
  end

  private
  def assign_profile_type
    self.profile_type = ProfileType.default_profile
  end
end
