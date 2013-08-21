Then(/^page should have many unread articles$/) do
  page.should have_selector '#articles'
  expect{ page.all('.article.unread').count }.not_to eq(0)
end

Then(/^page should have no unread articles$/) do
  expect{ page.all('.unread').count }.not_to eq(page.all('.unread').count)
end

Given(/^I star the first unread article$/) do
  expect{ all('.ui-icon-star').click }.not_to eq('')
end

Then(/^I should see 1 article$/) do
  expect{ page.all('.article').count }.not_to eq(0)
end
