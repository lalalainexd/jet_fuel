#Shorten URL
Given(/^that I am an anonymous user of the system$/) do
  #pending # express the regexp above with the code you wish you had
  #TODO finish this shizzz
end

When(/^I visit the site$/) do
  visit "/"
end

When(/^give a URL to the service$/) do
  fill_in('originalUrl', :with => 'http://www.lalalainexd.com')
  click_on('Fuel it!')
end

Then(/^I expect it to return a service shortened URL$/) do
  short_url = Url.find_by_original('http://www.lalalainexd.com').short
  page.has_content? short_url
end

#Redirect
Given(/^I have a shortened URL from the service$/) do
  #TODO what do?
end

When(/^I follow the shortened URL$/) do
  visit "/#{@short_url}"
end

Then(/^I expect to be redirected to the original URL$/) do
  url = page.current_url
  expect(url.scan(/http:\/\/www\.lalalainexd\.com\/?/)).to_not be_nil
end
