Then(/^the status code response should be "(\d+)"$/) do |status|
  last_response.status.should eql status.to_i
end

Then(/^the content type response should be JSON$/) do
  steps %Q{ Then the content type response should be "application/json;charset=utf-8" }
end

Then(/^the content type response should be "(.*?)"$/) do |content_type|
  last_response.header["content-type"].should eql content_type
end

Then(/^the JSON response should have error for "(.*?)" with "(.*?)"$/) do |attribute, message|
  errors = JSON.parse(last_response.body)["errors"]
  errors.should include({attribute => [message]})
end

Then(/^the response body with the following JSON:$/)do |response_json|
  got      = JSON.parse(last_response.body.chomp)
  expected = JSON.parse(response_json)

  expected.should == got
end

Then(/^the response body with following href in the header location$/) do
  user = HealthHistory::User.first
  last_response.location.should eq user.href
end


