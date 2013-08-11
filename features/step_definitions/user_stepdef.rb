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
