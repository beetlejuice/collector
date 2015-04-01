module PresentationHelper
  def generate_test_data slides
  	time_interval = 1..10 # should be a constant
  	test_data = []
  	slides.each do |slide_name| 
      test_data << {
        slide: slide_name,
  		  time: rand(time_interval),
  		  attitude: %i(negative, positive).sample # attitude is picked randomly here
  	  }
    end
  	test_data
  end
end