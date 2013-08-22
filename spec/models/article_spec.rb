require 'spec_helper'
require 'feed_manager'

describe Article do

  context 'with no context data' do
    before(:all) do
      @valid_article = build(:article)
    end
    it 'stores a valid article' do
      expect(@valid_article.save).to eq(true)
    end

    it 'generates a hash tag with link' do
      @valid_article.save!
      expect(@valid_article.hash_tag).not_to eq(nil)
    end
  end

  context 'on article creation from feed' do
    before(:all) do
      @profile_type = create(:profile_type)
      @valid_article = build(:article)
      @user = create(:generic_user)
      @channel = create(:channel, :user_id => @user.id)

      # Clean up from articles loaded by feed_manager from test feed
      Article.delete_all

      # Creates a feed with 4 items
      @feed = FeedManager.instance.create_test_feed_object
    end

    it 'creates articles from feed items' do
      Article.create_from_feed_items @feed.items, @channel.id
      expect(@channel.articles.size).to eq(4)
    end

    it 'adds new items from feed items' do
      # no items initially
      Article.add_from_feed_items @feed.items, @channel.id
      expect(@channel.articles.size).to eq(4)

      # 4 items initially from first add, adding same feed should not add new articles
      Article.add_from_feed_items @feed.items, @channel.id
      expect(@channel.articles.size).to eq(4)

      # 4 items initially from first add, items has no pub_date, adding same feed should add new articles since there's no dates to compare
      @feed.items.each{ |i| i.pub_date = nil }
      Article.add_from_feed_items @feed.items, @channel.id
      expect(@channel.articles.size).to eq(8)

      # 12 articles initially from previous adds, new feed has new articles and should be added
      new_feed = FeedManager.instance.create_test_feed_object
      Article.add_from_feed_items new_feed.items, @channel.id
      expect(@channel.articles.size).to eq(12)
    end
  end

  context 'with only one article' do
    before(:all) do
      @profile_type = create(:profile_type)
      @user = create(:generic_user)
      @channel = create(:channel, :user_id => @user.id)

      # Clean up from articles loaded by feed_manager from test feed
      Article.delete_all

      @article = create(:article)
      @channel.articles << @article

      # Creates a feed with 4 items
      @feed = FeedManager.instance.create_test_feed_object
    end
    it 'marks an article as read' do
      expect(@article.mark_as_read).to eq(true)
    end

    it 'toggles article star' do
      # initial state (false)
      current_star = @article.starred

      # toggle star
      expect(@article.toggle_starred).to eq(true)

      # starred attribute changes?
      expect(@article.starred).not_to eq(current_star)

      # toggle star again
      expect(@article.toggle_starred).to eq(true)

      # is it back to initial state?
      expect(@article.starred).to eq(current_star)
    end

    it 'checks if article belongs to user' do
      expect(@article.belongs_to_user(@user)).to eq(true)
    end
  end
end
