require 'spec_helper'

describe "Articles" do
  before do
    @profile_type ||= create(:profile_type)
    sign_in_as_a_valid_user
    @channel ||= create(:channel, :user_id => @user.id)
    @article ||= create(:article, :channel_id => @channel.id)
  end
  describe "GET /articles/full_list" do
    it "gets article complete list" do
      get user_articles_full_list_url

      response.status.should be(200)
      expect(response).to render_template(:index)
    end
  end

  describe "GET /articles/starred" do
    it "gets articles starred" do
      get user_articles_starred_url

      response.status.should be(200)
      expect(response).to render_template(:index)
    end
  end

  describe "GET /channels/1/articles/mark_all" do
    it "marks all articles of channel 1 as read" do
      get mark_all_user_channel_articles_url(@channel), nil, { 'HTTP_ACCEPT' => 'application/json' }

      response.status.should be(200)
    end
  end

  describe "GET /articles/1/mark_as_read" do
    it "marks one article as read" do
      get mark_as_read_user_article_url(@article), nil, { 'HTTP_ACCEPT' => 'application/json' }

      response.status.should be(200)
    end
  end

  describe "GET /articles/toggle_starred" do
    it "stars an article or removes star" do
      get toggle_starred_user_article_url(@article), nil, { 'HTTP_ACCEPT' => 'application/json' }

      response.status.should be(200)
    end
  end
end
