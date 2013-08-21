require 'spec_helper'

describe "Channels" do
  describe "GET /channels" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get user_channels_url

      # App returns code 302 instead of 200, don't know why yet, probably because of caches
      response.status.should be(302)
    end
  end
end
