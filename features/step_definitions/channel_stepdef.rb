Given(/^I click "(.*?)" link from channel manager$/) do |link_name|
  within("#dynamic_content") do
    click_link link_name
  end
end

Given(/^I fill in Channel Url with "(.*?)"$/) do |value|
  within('#dynamic_content') do
    fill_in('channel_url', :with => value)
  end
end

When(/^I click Add button from channel manager$/) do
  within('#dynamic_content') do
    click_button 'Add'
  end
end

Given(/^I have "(.*?)" channel$/) do |count|
  Channel.delete_all
  count.to_i.times do
    FactoryGirl.create :channel, :user_id => retrive_test_account.id
  end
end

Given(/^I am on manage channels section$/) do
  goto_channel_index
end

Then(/^page should have my channel information$/) do
  @channel = retrive_test_account.channels.first
  page.should have_content @channel.name
  page.should have_content @channel.url
end

Given(/^I have no channels$/) do
  page.should have_content "No channels"
end
