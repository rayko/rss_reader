module FeedManagerTest
  def create_test_feed_object
    items = []
    4.times do
      items << FeedItem.new('Some Article From Feed', 'Some content', 'http://link-to-article-in-feed.com', Time.now)
    end
    return Feed.new :title => 'Some Feed',
    :items => items,
    :url => 'http://somesite.com',
    :feed_url => 'http://somefeed.com',
    :valid => true
  end

  def clear_cache
    @@feed_list = {}
  end

  private
  # Only for tests purposes
  def fetch_test_feed
    logger.info 'FeedManager: env is test, fetching test data'
    data = Feedzirra::Feed.parse File.open(Rails.root.join('test', 'test_feeds', 'valid_feed.xml'), 'r').read
    return Feed.new :title => data.title,
                    :items => data.entries,
                    :url => data.url,
                    :feed_url => data.feed_url,
                    :valid => true

  end

  def get_file filename
    if File.exists?(Rails.root.join('test', 'test_feeds', filename))
      # Return file if exists
      return File.open(Rails.root.join('test', 'test_feeds', filename)).read
    else
      # Fall back to a known file
      return File.open(Rails.root.join('test', 'test_feeds', 'valid_feed.xml')).read
    end
  end
end
