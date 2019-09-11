module Parser
    class Entry
        def initialize(raw)
            @raw = raw
        end

        def raw
            @raw
        end
        
        def ip
            @raw.split(' ').last
        end

        def path
            @raw.split(' ').first
        end
    end
end