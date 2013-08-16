class FeedManager
  require 'feedzirra'

  def fetch_feed(url)
    if Rails.env  == 'test'
      Feedzirra::Feed.parse File.open(Rails.root.join('test', 'mspaintadventures_test_feed.xml'), 'r').read
    else
      Feedzirra::Feed.fetch_and_parse url
    end
  end

  def get_items(url)
    data = fetch_feed(url)

    # Feed validation
    # Feedzirra does the fetching and parsing with its own parsers,
    # if Feedzirra returns nil after a fetch, the feed is not valid.
    unless data.nil?
      return Feed.new data.title, data.entries, data.url, data.feed_url, true
    else
      return Feed.new '', [], '', '', false
    end

  end

  def update_feed(url)
  end
end

class Feed
  attr_accessor :title, :items, :url, :feed_url, :valid

  def initialize(title, items, url, feed_url, valid)
    title.blank? ? self.title = 'Untitled' : title
    self.url = url
    self.feed_url =feed_url
    self.valid = valid
    self.items = []

    items.each do |item|
      self.items << FeedItem.new(item.title, item.url, item.summary, item.published)
    end
  end

  def valid?
    self.valid
  end
end

class FeedItem
  attr_accessor :title, :url, :description, :pub_date

  def initialize(title, url, description, pub_date)
    self.title = title
    self.url = url
    self.description = description
    self.pub_date = pub_date || DateTime.now
  end
end
