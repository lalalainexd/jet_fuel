#Shorten URL
Given(/^that I am an anonymous user[ of the system]?$/) do
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


Before('@redirect') do
  url = Url.find_or_create_by_original('http://www.facebook.com')
  @short_url = url.short
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
  expect(url.scan(/https?:\/\/www\.facebook\.com\/?/)).to_not be_empty
end

Given(/^a shortened url for (http:\/\/www\.[\w]+\.com$)/) do |url|
  Url.find_or_create_by_original(url)
end

Given(/^(http:\/\/www\.[\w]+\.com) has (\d+) visits$/) do |url, visits|
  url = Url.find_by_original(url)
  visits.to_i.times { JetFuel::UrlController.visit url.short }
  url.save
end

Then(/^I expect to see the URLs sorted by popularity$/) do
  page.should have_selector('table.urls')
  page.should have_css('table.urls')
end

