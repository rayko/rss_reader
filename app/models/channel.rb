class Channel < ActiveRecord::Base
  attr_accessible :title, :url

  belongs_to :user

  before_save :perform_first_fetch

  require 'feed_manager'

  def update_feed
    feed = FeedManager.new.get_items self.url
    # Article.add_from_feed_items feed.items, self.id
  end

  private
  def perform_first_fetch
    feed = FeedManager.new.get_items self.url
    self.title = feed.title
    # Article.create_from_feed_items feed.items, self.id
  end
end
