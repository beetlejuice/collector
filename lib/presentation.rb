class Presentation

  require 'json'

  def initialize driver
    @driver = driver
  end

  def turn_slide direction, attitude = nil
    ensure_is_current_frame
    
    body = @driver.find_element(:tag_name => "body")

    start_x, offset_x = 
      case direction
      when :forward then 3*body.size.width/4, -body.size.width/2
      when :backward then body.size.width/4, body.size.width/2
      else raise 'Wrong direction of turning slide!'
      end

    start_y = 
      case attitude
      when :positive then body.size.height/4
      when :negative then 3*body.size.height/4
      else body.size.height/4
      end

    @driver.action.move_to(body, start_x, start_y).
                   click_and_hold.
                   move_by(offset_x, 0).
                   release.
                   perform
  end

  def get_kpi
    raw_kpi = @driver.execute_script("return window.localStorage.getItem('KPI')")
    JSON.parse(raw_kpi)
  end

  private

  def ensure_is_current_frame
    # Add check and switch only if it fails
    @driver.switch_to.default_content
    current_frame = @driver.find_element(:xpath => "//div[@class='slide current']/iframe").attribute("id")
    @driver.switch_to.frame current_frame
  end

end