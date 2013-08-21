# -*- coding: utf-8 -*-
class FeedManager
  require 'feedzirra'
  private_class_method :new

  @@feed_list = {}
  @@instance = nil

  # Allows only one instance in the app
  def self.instance
    unless @@instance
      @@instance = new
    end
    return @@instance
  end

  # Tries to get a feed from either Feedzirra or local cache
  # If there is no cached feed, it creates one and returns it
  def get_feed(url)
    logger.info 'FeedManager: Starting feed request process'
    if Rails.env  == 'test'
      fetch_test_feed
    else
      cached_feed = get_feed_from_cache(url)
      if cached_feed
        logger.info 'FeedManager: Feed found in cache, returning it'
        return cached_feed
      else
        logger.info "FeedManager: No feed found in cache, requesting to #{url}"
        data = Feedzirra::Feed.fetch_and_parse url unless url.blank?
        # Feed validation
        # Feedzirra does the fetching and parsing with its own parsers,
        # if Feedzirra returns nil after a fetch, the feed is not valid.
        unless data.nil? || data.class == Fixnum
          logger.info 'FeedManager: Feed fetched and valid'
          feed = Feed.new :title => data.title,
                          :items => data.entries,
                          :url => data.url,
                          :feed_url => data.feed_url,
                          :valid => true
          store_feed(feed)
          return feed
        else
          logger.info "FeedManager: Invalid feed returned from #{url} returning dummy invalid feed"
          feed = Feed.new :valid => false
          return feed
        end
      end
    end
  end


  # Gets a feed from either Feedzirra or cache and returns the entries.
  def update_feed(url)
    feed = get_feed(url)
    if feed.valid?
      unless feed.expired?
        return feed.items
      else
        feed = Feed.new :title => data.title,
                        :items => data.entries,
                        :url => data.url,
                        :feed_url => data.feed_url,
                        :valid => true
        return feed.items
      end
    end
  end


  private
  # Only for tests purposes
  def fetch_test_feed
    logger.info 'FeedManager: env is test, fetching test data'
    data = Feedzirra::Feed.parse File.open(Rails.root.join('test', 'mspaintadventures_test_feed.xml'), 'r').read
    return Feed.new :title => data.title,
                    :items => data.entries,
                    :url => data.url,
                    :feed_url => data.feed_url,
                    :valid => true
  end

  # Saves a feed in cache, returns a Feed object
  def store_feed(feed)
    if @@feed_list.keys.include? feed.feed_url
      logger.info "FeedManager: Updating feed from #{feed.feed_url} in cache"
      @@feed_list[feed.feed_url] = feed if @@feed_list[feed.feed_url].expired?
    else
      logger.info "FeedManager: Storing new feed from #{feed.feed_url} in cache"
      @@feed_list[feed.feed_url] = feed
    end
  end

  # Retrives a feed from cache, returns a Feed object
  def get_feed_from_cache(url)
    if @@feed_list[url] && !@@feed_list[url].expired?
      logger.info "FeedManager: Found feed #{url} in cache and is not expired"
      return @@feed_list[url]
    else
      logger.info "FeedManager: No feed found in cache for #{url}"
      return nil
    end
  end

  def logger
    Rails.logger
  end
end

class Feed
  attr_accessor :title, :items, :url, :feed_url, :valid,
                :created_at

  def initialize(options)
    options[:title].blank? ? self.title = 'Untitled' : self.title = options[:title]
    self.url = options[:url]
    self.feed_url = options[:feed_url]
    self.valid = options[:valid]
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

class FeedItem
  attr_accessor :title, :url, :description, :pub_date

  def initialize(title, url, description, pub_date)
    self.title = title
    self.url = url
    self.description = description
    self.pub_date = pub_date || DateTime.now
  end
end
