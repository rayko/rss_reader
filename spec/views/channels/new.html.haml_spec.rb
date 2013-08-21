require 'spec_helper'

describe "user/channels/new" do
  before(:each) do
    assign(:channel, stub_model(Channel,
      :title => "MyString",
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new channel form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_channels_url, "post" do
      assert_select "input#channel_url[name=?]", "channel[url]"
    end
  end
end
