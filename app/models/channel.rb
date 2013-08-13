class Channel < ActiveRecord::Base
  attr_accessible :title, :url

  belongs_to :user

  before_save :validate_feed
  after_save :perform_first_fetch

  require 'feed_manager'

  has_many :articles

  def update_feed
    feed = FeedManager.new.get_items self.url
    Article.add_from_feed_items feed.items, self.id
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
