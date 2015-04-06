describe 'Checking spelling', :include_presentation_helper, :include_speller do
  it 'should contains correct texts' do
    presentation_texts = get_presentation_texts @url
    
    presentation_texts.each do |slide_texts_hash|
    	slide_texts = slide_texts_hash['texts']
      check_result = spellcheck slide_texts, 'html'
      expect(check_result[:has_errors]).to be false
    end
  end
end