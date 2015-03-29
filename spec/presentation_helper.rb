module PresentationHelper
  require 'json'

  def setup
    @driver.manage.window.resize_to(1044, 898)
  end

  def generate_test_data slides
  	MIN_TIME = 1
  	MAX_TIME = 10
  	test_data = []
  	slides.each do |slide_name| 
      test_data << {
        slide: slide_name
  		  time: rand(MIN_TIME..MAX_TIME),
  		  attitude: %i(positive, negative).sample # here attitude is picked by random
  	  }
    end
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