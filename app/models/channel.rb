class Channel < ActiveRecord::Base
  attr_accessible :name, :url, :user_id

  belongs_to :user

  # before_create :validate_feed
  after_create :perform_first_fetch

  require 'feed_manager'

  has_many :articles, :dependent => :delete_all

  require "channel_uniq_url_validator"
  require "channel_valid_feed_validator"
  validates :user_id, :presence => true
  validates :url, :presence => true, :uniq_url => true, :valid_feed => true, :on => :create
  validates_with ChannelLimitValidator


  def update_feed
    new_items = FeedManager.instance.update_feed self.url
    Article.add_from_feed_items new_items, self.id
  end

  def starred_articles
    self.articles.select{ |a| a.starred }
  end

  def unread_articles_count
    self.articles.select{ |a| !a.read }.size
  end

  private
  def perform_first_fetch
    feed = FeedManager.instance.get_feed self.url
    self.update_attribute :name, feed.title if self.name.blank?
    Article.create_from_feed_items feed.items, self.id
  end
end
