require 'feed_item'

class Feed
  attr_accessor :title, :items, :url, :feed_url, :valid,
                :created_at

  def initialize(options={})
    options[:title].blank? ? self.title = 'Untitled' : self.title = options[:title]
    self.url = options[:url]
    self.feed_url = options[:feed_url]
    self.valid = options[:valid] || false
    self.items = []
    self.created_at = Time.now

    if options[:items]
      options[:items].each do |item|
        self.items << FeedItem.new(item.title, item.url, item.summary, item.published)
      end
    end
  end

  def valid?
    self.valid
  end

  def expired?
    (Time.now - self.created_at) > 300 # 5 minutes
  end
end
