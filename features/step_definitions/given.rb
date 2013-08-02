# -*- encoding : utf-8 -*-
Given(/^I have valid attributes to create an user$/) do
  @data = {
    name:  "Test Name",
    email: "testname@test.com",
    cpf:   "51178387000101",
    dob:   "10/11/1950"
  }
end

Given(/^I change "(.*?)" value to "(.*?)"$/) do |field, value|
  @data[field.to_sym] = value
end

Given(/^that an user with email "(.*?)" already exists$/) do |email|
  FactoryGirl.create(:user, :email => email)
end

Given(/^that an user with name "(.*?)" already exists$/) do |name|
  FactoryGirl.create(:user, :name => name)
end
