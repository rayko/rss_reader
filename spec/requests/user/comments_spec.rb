require 'spec_helper'

describe "Comments" do
  before do
    @profile_type ||= create(:profile_type)
    sign_in_as_a_valid_user
    @channel ||= create(:channel, :user_id => @user.id)
    @article ||= create(:article, :channel_id => @channel.id)
  end
  describe "GET user/articles/1/comments" do
    it "gets comments from article 1" do
      get user_article_comments_url(@article)

      response.status.should be(200)
    end
  end

  describe "POST user/articles/1/comments" do
    it "posts a comment for article 1" do
      post user_article_comments_url(@article), 'comment[text]' => 'Some text', 'comment[article_id]' => @article.id

      response.status.should be(200)
    end
  end
end
