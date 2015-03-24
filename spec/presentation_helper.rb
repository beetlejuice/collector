module PresentationHelper
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

  def get_slide_names

  end

  def expected_kpi

  end
end