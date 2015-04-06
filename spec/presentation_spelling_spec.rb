describe 'Checking spelling', :include_presentation_helper, :include_speller do
  it 'should contains correct texts' do
    texts = get_texts @url

    text_files = []
    text_files.each do |s_f|
      slide_content = f(s_f)
      check_result = spellcheck slide_content, 'html'
      expect(check_result[:has_errors]).to be false
    end
  end
end