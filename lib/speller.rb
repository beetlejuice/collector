module Speller
  require 'open-uri'
  require 'net/http'
  require 'json'

  API_URL = 'http://speller.yandex.net'
  OPTIONS = '0'

  def spellcheck text, mode = 'html'
    check_settings = {options: OPTIONS, format: mode}

    uri = URI.parse(API_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new('/services/spellservice.json/checkText')
    req.body = prepare_body text, check_settings
    res = http.request(req)

    # raise "Bad server response! - #{res.code}" unless res == Net::HTTPSuccess

    parsed_response = JSON.parse(res.body)
    {has_errors: !parsed_response.empty?, response: parsed_response}
  end

  private

  def prepare_body body, settings
    # Optionally format encoding here
    'text=' + body + '&options=' + settings[:options] + '&format=' + settings[:format]
  end
end