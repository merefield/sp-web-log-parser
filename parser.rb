module Parser
    class Parser::Entry
        def initialize(raw)
            @raw = raw
        end

        def raw
            @raw
        end
        
        def ip
            ip = @raw.split(' ').last
        end

        def path
            ip = @raw.split(' ').first
        end
    end

    class Parser::EntryCollection
        def initialize(io)
            @io = io
            @entry_collection = []
            @row_count = 0
            @io.each_line do |line|
                @row_count += 1
                @entry_collection << Parser::Entry.new(line)
            end
        end

        def row_count
            @row_count
        end

        def page_count(page)
            count = 0
            @entry_collection.each do |e|
                count += ((page == e.path) ? 1 : 0)
            end
            count
        end
    end
end