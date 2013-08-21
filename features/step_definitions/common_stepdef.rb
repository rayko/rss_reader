Given(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in(field.downcase.split(' ').join('_'), :with => value)
end

Then(/^page should have notice message "(.*?)"$/) do |message|
  page.should have_content(message)
end

Given(/^I click "(.*?)" link$/) do |name|
  click_link name
end

When(/^I click "(.*?)" button$/) do |name|
  click_button name
end

Then(/^I should see a "(.*?)" link$/) do |link|
  page.should have_content link
end

Given(/^I am on the index page$/) do
  goto_home_section
end

When(/^I confirm dialog$/) do
  page.driver.browser.switch_to.alert.accept
end

When(/^wait page to load properly$/) do
  wait_until do
    page.evaluate_script('$.active') == 0
  end
end
