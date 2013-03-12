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
