class Channel < ActiveRecord::Base
  attr_accessible :title, :url

  belongs_to :user

  # before_create :validate_feed
  after_create :perform_first_fetch

  require 'feed_manager'

  has_many :articles, :dependent => :delete_all

  require "channel_uniq_url_validator"
  require "channel_valid_feed_validator"
  validates_with ChannelLimitValidator
  validates :url, :uniq_url => true, :valid_feed => true

  def update_feed
    feed = FeedManager.instnace.get_items self.url
    Article.add_from_feed_items feed.items, self.id
  end

  def starred_articles
    self.articles.select{ |a| a.starred }
  end

  private
  def perform_first_fetch
    feed = FeedManager.instance.get_items self.url
    self.update_attribute :name, feed.title
    Article.create_from_feed_items feed.items, self.id
  end
end
