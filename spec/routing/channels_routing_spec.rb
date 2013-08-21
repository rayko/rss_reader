require "spec_helper"

describe User::ChannelsController do
  describe "routing" do

    it "routes to #index" do
      get("user/channels").should route_to("user/channels#index")
    end

    it "routes to #new" do
      get("user/channels/new").should route_to("user/channels#new")
    end

    it "routes to #show" do
      get("user/channels/1").should route_to("user/channels#show", :id => "1")
    end

    it "routes to #edit" do
      get("user/channels/1/edit").should route_to("user/channels#edit", :id => "1")
    end

    it "routes to #create" do
      post("user/channels").should route_to("user/channels#create")
    end

    it "routes to #update" do
      put("user/channels/1").should route_to("user/channels#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("user/channels/1").should route_to("user/channels#destroy", :id => "1")
    end

  end
end
