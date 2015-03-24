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

    @driver.navigate.to $url
    presentation = Presentation.new(@driver)
    loop do
      # wait and record time
      presentation.turn_slide forward
      break if presentation.is_last_slide?
    end
    actual_kpi = presentation.get_kpi
    expect(actual_kpi).to equal(expected_kpi)
  end
end