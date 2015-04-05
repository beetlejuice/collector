describe 'Collecting KPI', :include_presentation_helper do
  it 'should collect standard KPI correctly' do
    presentation = Presentation.new(@driver, @url)

    slides = presentation.get_slides
    test_data = generate_test_data slides

    presentation.start
    test_data.each do |td|
      time, attitude = td.values_at(:time, :attitude)
      sleep time
      presentation.turn_slide :forward, attitude
    end

    actual_kpi = presentation.get_standard_kpi
    expect(actual_kpi).to eq(test_data)
  end
end