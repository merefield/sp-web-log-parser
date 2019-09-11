require_relative "entry_collection"

filename = ARGV.pop
raise "Need to specify a file to process" unless filename

this_collection = Parser::EntryCollection.new(IO.binread(filename))
puts '####### Totals by Page ########'
this_collection.total_by_page
puts '####### Totals by Unique Visits ########'
this_collection.unique_by_page

