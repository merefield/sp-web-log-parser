require_relative '../parser'

RSpec.describe Parser::Entry do
  it 'creates a entry class' do
    entry = Parser::Entry.new('')
    expect(entry).to be_kind_of(Parser::Entry)
  end

  it 'instantiates it with some raw value' do
    SOME_TEXT = 'some text'
    entry = Parser::Entry.new(SOME_TEXT)
    expect(entry.raw).to eql(SOME_TEXT)
  end

  it 'returns a valid IP address' do
    EXAMPLE_ENTRY = '/about/2 836.973.694.403'
    entry = Parser::Entry.new(EXAMPLE_ENTRY)
    expect(entry.ip).to eql('836.973.694.403')
  end

  it 'returns a valid path address' do
    ANOTHER_EXAMPLE_ENTRY = '/about/2 836.973.694.403'
    entry = Parser::Entry.new(ANOTHER_EXAMPLE_ENTRY)
    expect(entry.path).to eql('/about/2')
  end
end

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
end    