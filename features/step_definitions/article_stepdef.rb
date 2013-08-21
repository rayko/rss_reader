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
