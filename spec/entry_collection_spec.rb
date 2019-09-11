require_relative '../entry_collection'

RSpec.describe Parser::EntryCollection do
  it 'creates an entry_collection class' do
    testIO = StringIO.new
    entry_collection = Parser::EntryCollection.new(testIO)
    expect(entry_collection).to be_kind_of(Parser::EntryCollection)
  end

  it 'returns correct number of rows' do
    testIO = StringIO.new
    testIO.string = "/help_page/1 929.398.951.889\n/contact 555.576.836.194\n/about/2 184.123.665.067"
    entry_collection = Parser::EntryCollection.new(testIO)
    expect(entry_collection.row_count).to eql 3
  end

  it 'returns correct count for page visits' do
    testIO = StringIO.new
    testIO.string = "/about/2 444.701.448.104\n/contact 543.910.244.929\n/about 126.318.035.038\n/about/2 836.973.694.403\n/index 316.433.849.805\n/index 802.683.925.780"
    entry_collection = Parser::EntryCollection.new(testIO)
    expect(entry_collection.page_count('/about/2')).to eql 2
  end

  it 'returns correct count for particular page visit' do
        testIO = StringIO.new
        testIO.string = "/about/2 444.701.448.104\n/contact 543.910.244.929\n/about 126.318.035.038\n/about/2 836.973.694.403\n/index 316.433.849.805\n/index 802.683.925.780"
        total_visits = Parser::EntryCollection.new(testIO)
        expect(total_visits.total_by_page.count).to eql 4
  end

  it 'returns correct count for particular unique page visits' do
    testIO = StringIO.new
    testIO.string = "/help_page/1 126.318.035.038
    /contact 184.123.665.067
    /home 184.123.665.067
    /about/2 444.701.448.104
    /help_page/1 929.398.951.889
    /index 444.701.448.104
    /help_page/1 722.247.931.582
    /about 061.945.150.735
    /help_page/1 646.865.545.408
    /home 235.313.352.950
    /contact 184.123.665.067
    /help_page/1 543.910.244.929
    /home 316.433.849.805
    /about/2 444.701.448.104
    /contact 543.910.244.929
    /about 126.318.035.038
    /about/2 836.973.694.403
    /index 316.433.849.805
    /index 802.683.925.780
    /help_page/1 929.398.951.889
    /contact 555.576.836.194
    /about/2 184.123.665.067
    /home 444.701.448.104
    /index 929.398.951.889
    /about 235.313.352.950
    /contact 200.017.277.774
    /about 836.973.694.403
    /contact 316.433.849.805
    /help_page/1 929.398.951.889"
    total_visits = Parser::EntryCollection.new(testIO)
    expect(total_visits.unique_by_page.count).to eql 6
  end
end    