Then(/^page should have many unread articles$/) do
  page.should have_selector '#articles'
  page.all('.article.unread').should_not eq(0)
end

Then(/^page should have no unread articles$/) do
  wait_ajax_calls
  page.all('.unread').count.should eq(0)
end

Given(/^I star the first unread article$/) do
  wait_ajax_calls
  all('.ui-icon-star').first.click
end

Then(/^I should see 1 article$/) do
  wait_ajax_calls
  all('.article').count.should eq(1)
end

When(/^I click the first article$/) do
  wait_ajax_calls
  all('.article.unread').first.click

end

Then(/^I should see 1 read article$/) do
  wait_ajax_calls
  all('.article').first.should_not have_css('.unread')
end

Then(/^I should see 1 read article and many unread articles$/) do
  wait_ajax_calls
  all('.article').first.should_not have_css('.unread')
  all('.unread').count.should_not eq(0)
end

When(/^I click All items link within channel articles$/) do
  within('#dynamic_content') do
    click_link ('All items')
  end
end

When(/^I click All items link within special channels$/) do
  find('.full_articles_list').click
end

Given(/^I have "(.*?)" channel with name "(.*?)"$/) do |count, name|
  Channel.delete_all
  count.to_i.times do
    retrive_test_account.channels << FactoryGirl.create(:channel, :name => name, :user_id => retrive_test_account.id)
  end

end
