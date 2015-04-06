module Speller
  require 'open-uri'
  require 'net/http'
  require 'json'

  API_URL = 'http://speller.yandex.net'
  OPTIONS = '0'

  def spellcheck texts, mode = 'html'
    check_settings = {options: OPTIONS, format: mode}

    uri = URI.parse(API_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new('/services/spellservice.json/checkTexts')
    req.body = prepare_body texts, check_settings
    res = http.request(req)

    fail "Bad server response! - #{res.code}" unless res.code == '200'

    parsed_response = JSON.parse(res.body)
    {has_errors: has_errors?(parsed_response), response: parsed_response}
  end

  private

  def prepare_body texts, settings
    # Optionally format encoding here
    text_body = 'text=' + texts.join('&text=')
    text_body + '&options=' + settings[:options] + '&format=' + settings[:format]
  end

  def has_errors? response
    !response.flatten.empty?
  end
end