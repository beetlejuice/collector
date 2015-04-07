module PresentationHelper
  require 'find'
  require 'json'

  STRUCTURE_FILE = 'structure_cn1.json' # should be set externally
  GLOBAL_PATH = '/Users/admin/Documents/Development/presentations/pharma/' # hardcode

  def get_presentation_slides url
    structure = get_structure url
    get_slides structure
  end

  def get_presentation_texts url
    structure = get_structure url
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

  def get_structure presentation_url
    full_path = presentation_url + STRUCTURE_FILE
    JSON.parse(open(full_path).read)
  end

  def get_slides structure_hash
    structure_hash['chapters']['visit']['content']
  end

  def get_i18n_file_paths slide_name, structure_hash
    slide_path = structure_hash['slides']["#{slide_name}"]['template'].chomp('/index.html')
    slide_i18n_path = File.join(GLOBAL_PATH, slide_path, '/i18n/ru/')
    Find.find(slide_i18n_path).select { |e| File.file? e }
  end

  def get_all_nested_values hash
    all_values = []
    get_nested_values = lambda do |hsh|
      hsh.each_value do |v|
        if v.is_a?(String) && !v.empty?
          all_values << v
        elsif v.is_a?(Hash)
          get_nested_values.call v
        # else
          # puts 'Blank string or inappropriate content type'
        end
      end
    end
    get_nested_values.call hash
    all_values
  end

  def get_strings text_file_path
    content_hash = JSON.parse(File.read text_file_path, encoding: 'bom|utf-8')
    get_all_nested_values content_hash
  end

  def get_slide_texts slide_name, structure_hash
    i18n_file_paths = get_i18n_file_paths slide_name, structure_hash # collect slide paths somewhere out of loop
    texts = []
    i18n_file_paths.each do |path|
      strings = get_strings(path)
      texts << strings unless strings.empty?
    end
    texts
  end
end