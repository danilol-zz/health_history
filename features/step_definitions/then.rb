Then /^I should see '(.*)'$/ do |text|
  last_response.body.should match(/#{text}/m)
end
