class FeedManager
  require 'feedzirra'

  def validate(url)
    # pending
  end

  def fetch_feed(url)
    if Rails.env  == 'test'
      Feedzirra::Feed.parse File.open(Rails.root.join('test', 'mspaintadventures_test_feed.xml'), 'r').read
    else
      Feedzirra::Feed.fetch_and_parse url
    end
  end

  def get_items(url)
    data = fetch_feed(url)
    return Feed.new data.title, data.items, data.url, feed_url
  end

  def update_feed(url)
  end
end

class Feed
  attr_accessor :title, :items, :url, :feed_url

  def initializer(title, items, url, feed_url)
    self.title = title
    self.url = url
    self.feed_url =feed_url
    self.items = []

    items.each do |item|
      self.items << FeedItem.new(item.title, item.url, item.description, item.published)
    end
  end
end

class FeedItem
  attr_accessor :title, :url, :description, :pub_date

  def initializer(title, url, description, pub_date)
    self.title = title
    self.url = url
    self.description = description
    self.pub_date = pub_date
  end
end
