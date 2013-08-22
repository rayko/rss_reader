require 'spec_helper'

describe Channel do
  context 'with no extra content' do
    before(:all) do
      @profile_type = create(:profile_type)
      @user = create(:generic_user)
      @user2 = create(:generic_user)
      @valid_channel = build(:channel, :name => 'Some Channel', :user_id => @user.id)
      @invalid_channel = Channel.new :user_id => @user.id
    end

    it 'stores a valid record' do
      expect(@valid_channel.save).to eq(true)
    end

    it 'rejects an invalid record' do
      expect(@invalid_channel.save).to eq(false)
    end

    it 'validates uniqueness of url per user' do
      channel = create(:channel, :user_id => @user.id)
      another_channel = build(:channel, :user_id => @user.id, :url => channel.url)
      expect(another_channel.save).to eq(false)

      another_channel = build(:channel, :user_id => @user2.id, :url => channel.url)
      expect(another_channel.save).to eq(true)
    end

    it 'validates channel limit' do
      new_user = create :generic_user
      new_user.channel_limit.times do
        create(:channel, :user_id => new_user.id)
      end
      new_channel = build(:channel, :user_id => new_user.id)
      expect(new_channel.save).to eq(false)
    end
  end

  context 'with test feed' do
    before(:all) do
      @user = create(:generic_user)
      @channel = create(:channel, :user_id => @user.id)
      @channel.articles << create(:article, :read => true)
      @channel.articles << create(:article, :starred => true)
    end

    it 'performs first fetch' do
      # Using mspaintadventures_test_feed.xml file in test/
      expect(@channel.articles).not_to eq(0)
    end

    it 'gets starred articles' do
      expect(@channel.starred_articles.size).to eq(1)
    end

    it 'gets unread articles count' do
      expect(@channel.unread_articles_count).to eq(41) # 40 from test feed, 1 created avobe
    end

    it 'updates feed' do
      pending 'need extra logic in feed manager to test this'
    end
  end
end
