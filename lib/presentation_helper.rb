module PresentationHelper
  require 'find'
  require 'json'

  STRUCTURE_FILE = 'structure_cn1.json' # should be set externally
  LOCAL_PATH = '/Users/admin/Documents/Development/presentations/pharma/' # hardcode

  def get_presentation_slides url
    structure = get_structure_json url
    get_slides structure
  end

  def get_presentation_texts url
    structure = get_structure_json url
    slides = get_slides structure
    texts = []
    slides.each do |slide_name|
      slide_texts = get_slide_texts slide_name, structure
      texts << {
        slide: slide_name,
        texts: slide_texts
      }
    end
    texts
  end

  def generate_test_data slides
  	time_interval = 1..10 # should be a constant
  	test_data = []
  	slides.each do |slide_name| 
      test_data << {
        slide: slide_name,
  		  time: rand(time_interval),
  		  attitude: %i(negative positive).sample # attitude is picked randomly here
  	  }
    end
  	test_data
  end

  private

  def get_structure_json presentation_url
    full_path = presentation_url + STRUCTURE_FILE
    JSON.parse(open(full_path).read)
  end

  def get_slides structure_hash
    structure_hash['chapters']['visit']['content']
  end

  def get_i18n_file_pathes slide_name, structure_hash
    slide_path = structure_hash['slides']["#{slide_name}"]['template'].chomp('/index.html')
    Find.find(LOCAL_PATH + slide_path).select { |e| File.file? e }
  end

  def get_strings text_file_path
    content_json = JSON.parse(File.read text_file_path)
    content_json.values # need to redesign - doesn't work for nested JSONs
  end

  def get_slide_texts slide_name, structure_hash
    i18n_file_pathes = get_i18n_file_pathes slide_name, structure_hash # Collect slide pathes somewhere out of loop
    texts = []
    i18n_file_pathes.each do |path|
      texts << get_strings path
    end
    texts
  end
end