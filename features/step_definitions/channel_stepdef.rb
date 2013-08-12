Given(/^I am a user of the site$/) do
  create_and_confirm_test_account
  login_test_account_with_email
end

Then(/^page should have "(.*?)"$/) do |text|
  page.should have_content text
end
