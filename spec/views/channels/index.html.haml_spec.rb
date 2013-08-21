require 'spec_helper'

describe "user/channels/index" do
  before(:each) do
    assign(:channels, [
      stub_model(Channel,
        :name => "Name",
        :url => "Url"
      ),
      stub_model(Channel,
        :name => "Name",
        :url => "Url"
      )
    ])
  end

  it "renders a list of channels" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
