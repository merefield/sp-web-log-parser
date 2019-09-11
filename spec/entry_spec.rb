require_relative '../entry'

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