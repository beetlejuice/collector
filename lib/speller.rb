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

    # raise "Bad server response! - #{res.code}" unless res == Net::HTTPSuccess

    parsed_response = JSON.parse(res.body)
    # {has_errors: !parsed_response.empty?, response: parsed_response}
  end

  private

  def prepare_body texts, settings
    # Optionally format encoding here
    text_body = 'text=' + texts.join('&text=')
    text_body + '&options=' + settings[:options] + '&format=' + settings[:format]
  end
end