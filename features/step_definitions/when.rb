# -*- encoding : utf-8 -*-
When /^I send a (GET|POST|PUT|DELETE) request to "([^"]*)"(?: with the following JSON:)?$/ do |method, *request|
  path = request.shift
  body = request.shift

  if body.present?
    page.driver.browser.header("Content-Type","application/json" )
    send(method.downcase.to_sym, path, body)
  else
    page.driver.send(method.downcase.to_sym, path)
    send(method.downcase.to_sym, path)
  end
end

When /^I send a POST request to "(.*?)" with this data$/ do |path|
  post path, @data.to_json
end
