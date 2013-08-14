class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :username, :login
  # attr_accessible :title, :body

  attr_accessor :login

  # Relations
  has_many :channels

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
    articles = []
    self.channels.each do |channel|
      articles << channel.articles
    end
    return articles.flatten
  end

  # Fetch starred articles
  def starred_articles
    articles = []
    self.channels.each do |channel|
      articles << channel.starred_articles
    end
    return articles.flatten
  end
end
