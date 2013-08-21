Given(/^I am a user of the site$/) do
  create_and_confirm_test_account
  login_test_account_with_email
end

Then(/^page should have "(.*?)"$/) do |text|
  page.should have_content text
end

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
