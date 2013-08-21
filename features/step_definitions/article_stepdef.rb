Then(/^page should have many unread articles$/) do
  page.should have_selector '#articles'
  expect{ page.all('.article.unread').count}.not_to eq(0)
end
