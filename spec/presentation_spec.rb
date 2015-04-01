$url = '<presentation_url>'

describe 'Collecting KPI' do
  it 'should collect standard KPI correctly' do
    # Open presentation url (+ make setup)
    # Ensure current slide is correct (why do we need this?, this is more about checking engine rather than testing KPIs)
    # Wait for random amount of time (1-10 second for example)
    # Go to the next slide
    # Repeat until the end of presentation
    # Get KPI
    # Check for equalness (generate reference string before?)

    presentation = Presentation.new(@driver, $url)

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