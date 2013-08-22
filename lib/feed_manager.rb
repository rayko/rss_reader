# -*- coding: utf-8 -*-
class FeedManager
  require 'feedzirra'
  require 'feed_manager_test'
  require 'feed'
  include FeedManagerTest
  private_class_method :new

  @@feed_list = {}
  @@instance = nil

  def self.clear_cache
    @@feed_list = {}
  end

  def self.feed_list
    @@feed_list
  end

  # Allows only one instance in the app
  def self.instance
    unless @@instance
      @@instance = new
    end
    return @@instance
  end

  # Tries to get a feed from either Feedzirra or local cache
  # If there is no cached feed, it creates one and returns it.
  # test flag considers url as either filename to parse a test
  # feed or a valid url to request real data
  def get_feed(url, test=false)
    logger.info 'FeedManager: Starting feed request process'
    cached_feed = get_feed_from_cache(url)
    if cached_feed
      logger.info 'FeedManager: Feed found in cache, returning it'
      return cached_feed
    else
      return request_feed(url, test)
    end
  end


  # Gets a feed from either Feedzirra or cache and returns the entries.
  # test flags considers url either a filename to parse a stored test
  # feed or a valid url to request real data
  def update_feed(url, test=false)
    feed = get_feed(url, test)
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
  def request_feed url, test=false
    logger.info "FeedManager: No feed found in cache, requesting to #{url}"
    begin
      if test
        data = Feedzirra::Feed.parse(get_file(url))
        data.feed_url = url
      else
        data = Feedzirra::Feed.fetch_and_parse url unless url.blank?
      end
    rescue Feedzirra::NoParserAvailable
      logger.info "FeedManager: Feedzirra failed to parse fetched data from #{url}"
      data = nil
    end
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
      feed = Feed.new
      return feed
    end

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
