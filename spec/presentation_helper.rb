module PresentationHelper
  require 'json'

  def setup
    @driver.manage.window.resize_to(1044, 898)
  end

  def generate_test_data size
  	MIN_TIME = 1
  	MAX_TIME = 10
  	test_data = []
  	size.times test_data << {
  		time: rand(MIN_TIME..MAX_TIME),
  		attitude: %i(positive, negative).sample
  	}
  	test_data
  end

  def get_slides
    STRUCTURE_FILEPATH = 'structure_cn0.json'
    structure = JSON.parse(File.read(STRUCTURE_FILEPATH))
    slides = structure["slides"]
  end

  def prepare_reference_kpi
    []
  end
end