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
    feed = FeedManager.new.get_items self.url
    Article.add_from_feed_items feed.items, self.id
  end

  def starred_articles
    self.articles.select{ |a| a.starred }
  end

  private
  def validate_feed
    feed = FeedManager.new.get_items self.url
    if feed.valid?
      feed.title.blank? ? self.name = 'Untitled' : self.name = feed.title
    else
      # rise exception?
    end
  end

  def perform_first_fetch
    feed = FeedManager.new.get_items self.url
    Article.create_from_feed_items feed.items, self.id
  end
end
