$: << File.dirname(__FILE__) + '/../lib'

require 'selenium-webdriver'
require 'rspec'

require 'presentation'

driver = Selenium::WebDriver.for :chrome,
                                 :switches => %w[--ignore-certificate-errors
                                                 --disable-popup-blocking
                                                 --disable-translate
                                                 --test-type]

Rspec.configure do |config|
  config.include PresentationHelper
  config.before(:each) { @driver = driver }
  config.after(:suite) { driver.quit }
end