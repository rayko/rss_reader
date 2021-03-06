Given(/^I click the signup link$/) do
  click_link "Sign Up"
end

Given(/^I created an account$/) do
  create_test_account
end

When(/^I click the confirmation link from the email$/) do
  user = User.find_by_username('lolcat')
  visit user_confirmation_path(:confirmation_token => user.confirmation_token)
end

Given(/^I created and confirmed my account$/) do
  create_and_confirm_test_account
end

Given(/^I fill in "(.*?)" with my email$/) do |field|
  user = User.find_by_username('lolcat')
  fill_in(field.downcase.split(' ').join('_'), :with => user.email)
end

Given(/^I fill in "(.*?)" with my password$/) do |field|
  user = User.find_by_username('lolcat')
  fill_in(field.downcase.split(' ').join('_'), :with => '123456789')
end

Given(/^I fill in "(.*?)" with my login name$/) do |field|
  user = User.find_by_username('lolcat')
  fill_in(field.downcase.split(' ').join('_'), :with => user.username)
end

Given(/^I am logged in$/) do
  login_test_account_with_email
end

Then(/^I should see my information$/) do
  user = retrive_test_account
  find_field('user_first_name').value.should eq user.first_name
  find_field('user_last_name').value.should eq user.last_name
  find_field('user_username').value.should eq user.username
  find_field('user_email').value.should eq user.email
end

Then(/^I should see "(.*?)" as "(.*?)" on my profile$/) do |value, field|
  visit edit_user_registration_path
  find_field('user_' + field.downcase.split(' ').join('_')).value.should eq value
end
