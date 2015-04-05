$: << File.dirname(__FILE__) + '/../lib'

require 'selenium-webdriver'
require 'rspec'

require 'presentation'
require 'presentation_helper'
require 'speller'

driver = Selenium::WebDriver.for :chrome,
                                 :switches => %w[--ignore-certificate-errors
                                                 --disable-popup-blocking
                                                 --disable-translate
                                                 --test-type]

URL = 'http://localhost:8081/'

RSpec.configure do |config|
  config.include PresentationHelper, :include_presentation_helper
  config.include Speller, :include_speller
  config.before(:suite) { @url = URL } # Need to pass constant instead of variable
  config.before(:each) { @driver = driver }
  config.after(:suite) { driver.quit }
end