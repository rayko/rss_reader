require 'spec_helper'

describe "Application" do
  describe "GET /" do
    it "loads the index" do
      get root_path

      # App returns code 302 instead of 200, don't know why yet, probably because of caches
      response.status.should be(200)
      expect(response).to render_template(:index)
    end
  end
end
