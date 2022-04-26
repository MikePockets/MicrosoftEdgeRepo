require 'rubygems'
require 'watir'
require 'selenium-webdriver'
options =  Selenium::WebDriver::IE::Options.new
options.ignore_zoom_level = true
@browser = Selenium::WebDriver.for(:ie, options: options)
#capabilities = Selenium::WebDriver::Remote::Capabilities.ie('se:ieOptions' => {'ie.edgechromium' => true, 'ie.edgepath' => 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'})
#capabilities.ignore_zoom_level = true
#@browser = Watir::Browser.new :ie, :capabilities => capabilities
#@browser.element(tag: 'html').send_keys('^0')
#sleep 2
@browser.goto("https://www.amazon.com/")
sleep 2
@browser.goto("https://www.google.com/#spf=1629494121956")


def signin_with_valid_data
  @browser.element(id: 'nav-link-accountList').hover
  @browser.element(class: 'nav-action-button').click
  @browser.button(id: 'signInSubmit').click
end

def validate_the_input(exptext)
  if @browser.text[exptext]
    puts 'Test passed'
  else
    puts 'Test failed. The page text is ' + @browser.text
  end

  @browser.goto("https://www.amazon.com/")
end

def signin_with_invalid_email
  @browser.element(id: 'nav-link-accountList').hover
  @browser.element(class: 'nav-action-button').click
  @browser.text_field(id: 'ap_email').set('wormike98@gmail.com')
  @browser.button(id: 'continue').click
  sleep(3)
end

def signin_with_valid_email_and_not_valid_password
  @browser.element(id: 'nav-link-accountList').hover
  @browser.element(class: 'nav-action-button').click
  @browser.text_field(id: 'ap_password').set('ghjghjghjgjh')
  @browser.button(id: 'signInSubmit').click
  sleep(3)
end

signin_with_valid_data
validate_the_input('Authentication required')
signin_with_invalid_email
validate_the_input('We cannot find an account with that email address')
signin_with_valid_email_and_not_valid_password
validate_the_input('Your password is incorrect')

=begin
'Authentication required
 We will email you a One Time Password (OTP) to authenticate your request.'

 There was a problem
  We cannot find an account with that email address

  There was a problem
  Your password is incorrect
=end
