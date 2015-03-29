$url = '<presentation_url>'

describe 'Collecting KPIs' do
  it 'should collect time on slides correctly' do
    # Open presentation url (+ make setup)
    # Ensure current slide is correct (why do we need this?, this is more about checking engine rather than testing KPIs)
    # Wait for random amount of time (1-10 second for example)
    # Go to the next slide
    # Repeat until the end of presentation
    # Get KPI
    # Check for equalness (generate reference string before?)

    slides = get_slides
    test_data = generate_test_data slides

    @driver.navigate.to $url
    presentation = Presentation.new(@driver)

    enumerator = test_data.each
    loop do
      time, attitude = enumerator.next.values_at(:time, :attitude)
      sleep time
      presentation.turn_slide :forward, attitude
    end

    actual_kpi = presentation.get_kpi
    reference_kpi = prepare_reference_kpi
    expect(actual_kpi).to equal(reference_kpi)
  end
end