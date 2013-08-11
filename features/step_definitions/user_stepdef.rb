Given(/^I am on the index page$/) do
  visit root_path
end

Given(/^I click the signup link$/) do
  click_link "Sign Up"
end

Given(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in('user_' + field.downcase.split(' ').join('_'), :with => value)
end

When(/^I press "(.*?)"$/) do |button|
  click_button(button)
end

Then(/^page should have notice message "(.*?)"$/) do |message|
  page.should have_content(message)
end

Given(/^I created an account$/) do
  user = User.create! :first_name => 'Lolcat',
  :last_name => 'McAlliester',
  :login => 'lolcat',
  :email => 'lolcat@example.com',
  :password => '123456789',
  :password_confirmation => '123456789'
end

When(/^I click the confirmation link from the email$/) do
  user = User.find_by_login('lolcat')
  visit user_confirmation_path(:confirmation_token => user.confirmation_token)
end

Given(/^I created and confirmed my account$/) do
  user = User.create! :first_name => 'Lolcat', :last_name => 'McAlliester', :login => 'lolcat',
  :email => 'lolcat@example.com', :password => '123456789', :password_confirmation => '123456789'

  user.confirm!
end

Given(/^I click "(.*?)" link$/) do |name|
  click_link name
end

Given(/^I fill in "(.*?)" with my email$/) do |field|
  user = User.find_by_login('lolcat')
  fill_in('user_' + field.downcase.split(' ').join('_'), :with => user.email)
end

Given(/^I fill in "(.*?)" with my password$/) do |field|
  user = User.find_by_login('lolcat')
  fill_in('user_' + field.downcase.split(' ').join('_'), :with => '123456789')
end

When(/^I click "(.*?)" button$/) do |name|
  click_button name
end

Then(/^I should see a "(.*?)" link$/) do |link|
  page.should have_content link
end
