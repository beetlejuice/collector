class Presentation
  require 'json'
  require 'open-uri'

  attr_accessor :driver, :url

  def initialize driver, url
    @driver = driver
    @url = url
  end

  def start
    url_with_parameter = @url + 'index.html?callNumber=1' # quick test code
    @driver.navigate.to url_with_parameter 
  end

  def turn_slide direction, attitude
    ensure_is_current_frame
    
    body = @driver.find_element(:tag_name => "body")

    start_x, offset_x = 
      case direction
      when :forward then [3*body.size.width/4, -body.size.width/2]
      when :backward then [body.size.width/4, body.size.width/2]
      else raise 'Wrong direction of turning slide!'
      end

    start_y = 
      case attitude
      when :positive then body.size.height/4
      when :negative then 3*body.size.height/4
      else raise 'Wrong attitude!'
      end

    @driver.action.move_to(body, start_x, start_y).
                   click_and_hold.
                   move_by(offset_x, 0).
                   release.
                   perform
  end

  def get_standard_kpi
    raw_kpi = get_kpi
    standard_kpi = []
    raw_kpi['slides'].each do |rkpi|
      standard_kpi << {
        slide: rkpi['id'],
        time: rkpi['time'],
        attitude: %i(negative positive)[rkpi['likes']]
      }
    end
    standard_kpi
  end

  private

  def ensure_is_current_frame
    # Add check and switch only if it fails
    @driver.switch_to.default_content
    current_frame = @driver.find_element(:xpath => "//div[@class='slide current']/iframe").attribute("id")
    @driver.switch_to.frame current_frame
  end

  def get_kpi
    raw_kpi = @driver.execute_script("return window.localStorage.getItem('KPI')")
    JSON.parse(raw_kpi)
  end
end