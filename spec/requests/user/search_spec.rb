require 'spec_helper'

describe "Search" do
  before do
    @profile_type ||= create(:profile_type)
    sign_in_as_a_valid_user
    @channel ||= create(:channel, :user_id => @user.id)
    @article ||= create(:article, :channel_id => @channel.id)
  end

  # This requires sphinx to be running "rake ts:start"
  describe "POST /user/search" do
    it "post search query and show result" do
      post user_search_url, 'search[query]' => 'some query'

      response.status.should be(200)
      expect(response).to render_template(:search)
    end
  end
end
