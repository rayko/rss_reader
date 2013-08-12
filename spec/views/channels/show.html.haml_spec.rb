require 'spec_helper'

describe "channels/show" do
  before(:each) do
    @channel = assign(:channel, stub_model(Channel,
      :title => "Title",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Url/)
  end
end
