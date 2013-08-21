require 'spec_helper'

describe "user/channels/edit" do
  before(:each) do
    @channel = assign(:channel, stub_model(Channel,
      :title => "MyString",
      :url => "MyString"
    ))
  end

  it "renders the edit channel form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_channel_url(@channel), "post" do
      assert_select "input#channel_name[name=?]", "channel[name]"
    end
  end
end
