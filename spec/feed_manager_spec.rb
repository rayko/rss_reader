require 'spec_helper'
require 'feed_manager'


# Tests here are based on files stored at test/test_feeds
#
# valid_feed.xml
# It's a valid XML file with real RSS data, it contains exaclty 40 entries
#
# invalid_feed.xml
# A malformed XML file with nothing real, just some text
#
# updated_feed.xml
# This is a copy of valid_feed.xml except one of the entries
# was manipulated to simulate a new entry. Exaclty 1 item
# has different pub_date, the other 39 are copies of the original file.
# However the logic of distinguish new entries is somewhere else,
# FeedManager will return the list of all items fetched

describe 'FeedManager' do
  it 'does not allow creating new instance' do
    expect{FeedManager.new}.to raise_error(NoMethodError)
  end

  it 'returns unique instance' do
    instance_1 = FeedManager.instance
    instance_2 = FeedManager.instance
    expect(instance_2).to eq(instance_1)
    instance_3 = FeedManager.instance
    expect(instance_3).to eq(instance_1)
  end

  it 'fetches and parses a valid feed' do
    manager = FeedManager.instance

    feed = manager.get_feed 'valid_feed.xml', true # enables testing
    expect(feed.valid?).to eq(true)
    expect(feed.items.size).to eq(40)
  end

  it 'stores fetched feed in cache' do
    # Clear cache
    FeedManager.clear_cache

    # Add new feed
    feed = FeedManager.instance.get_feed 'valid_feed.xml', true # enables testing
    expect(FeedManager.feed_list.size).to eq(1)
    expect(FeedManager.feed_list['valid_feed.xml'].items.size).to eq(feed.items.size)
    expect(FeedManager.feed_list.keys.first).to eq('valid_feed.xml')

    # Attemp to add the same feed, cache shouldn't change
    feed = FeedManager.instance.get_feed 'valid_feed.xml', true # enables testing
    expect(FeedManager.feed_list.size).to eq(1)
    expect(FeedManager.feed_list['valid_feed.xml'].items.size).to eq(feed.items.size)
    expect(FeedManager.feed_list.keys.first).to eq('valid_feed.xml')
  end

  it 'returns invalid feed when fetching invalid data' do
    FeedManager.clear_cache

    feed = FeedManager.instance.get_feed 'invalid_feed.xml', true # enables testing
    expect(feed.valid?).to eq(false)
    expect(FeedManager.feed_list.size).to eq(0)
  end

  it 'updates feed' do
    FeedManager.clear_cache

    feed = FeedManager.instance.get_feed 'valid_feed.xml', true # enables testing

    FeedManager.clear_cache # Force store in cache when updating

    new_entries =  FeedManager.instance.update_feed 'updated_feed.xml', true # enables testing
    expect(new_entries.size).to eq(40)
    expect(FeedManager.feed_list.size).to eq(1)
  end
end
