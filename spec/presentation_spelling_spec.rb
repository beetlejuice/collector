describe 'Checking spelling', :include_speller do
  it 'should contains correct text' do
    slide_files = []
    slide_files.each do |s_f|
      slide_content = f(s_f)
      check_result = spellcheck slide_content
      expect(check_result[:has_errors]).to be false
    end
  end
end