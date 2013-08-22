require 'spec_helper'

describe "Channels" do
  before do
    @profile_type = create :profile_type
    sign_in_as_a_valid_user
    @channel ||= create(:channel, :user_id => @user.id)
  end
  describe "GET user/channels" do
    it "load channel index" do
      get user_channels_url

      response.status.should be(200)
      expect(response).to render_template(:index)
    end
  end

  describe "GET user/channels/new" do
    it 'loads form page for new channel' do
      get new_user_channel_url

      response.status.should be(200)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST user/channels' do
    it 'creates channel and redirects to index' do
      post user_channels_url, :channel => { :url => 'http://someurl.com' }

      # App gives 302 instead of 200, don't know why
      response.status.should be(302)
      expect(response).to redirect_to user_channels_url
      follow_redirect!

      response.status.should be(200)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET user/channels/1' do
    it 'loads channel show' do
      get user_channel_url(@channel)

      response.status.should be(200)
      expect(response).to render_template(:show)
    end
  end

  describe 'PUT user/channel/1' do
    it 'updates a channel and redirects to channel index' do
      put user_channel_url(@channel), 'channel[name]' => 'My Channel'

      # App gives 302 instead of 200, don't know why
      response.status.should be(302)
      expect(response).to redirect_to(user_channels_url)
      follow_redirect!

      response.status.should be(200)
      expect(response).to render_template(:index)
    end
  end

  describe 'DELETE user/channel/1' do
    it 'destroys a channel and redirects to channel index' do
      delete user_channel_url(@channel)

      # App gives 302 instead of 200, don't know why
      response.status.should be(302)
      expect(response).to redirect_to(user_channels_url)
      follow_redirect!

      response.status.should be(200)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET users/channels/list' do
    it 'loads channel list for ajax content' do
      get user_channels_list_url

      response.status.should be(200)
      expect(response).to render_template(:list)
    end
  end

  describe 'GET users/channels/1/edit' do
    it 'loads channel edit' do
      get edit_user_channel_url(@channel)

      response.status.should be(200)
      expect(response).to render_template(:edit)
    end
  end

end
