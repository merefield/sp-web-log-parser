require_relative "entry"

module Parser
    class EntryCollection
        def initialize(io)
            @io = io
            @entry_collection = []
            @row_count = 0
            @io.each_line do |line|
                @row_count += 1
                @entry_collection << Entry.new(line)
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

        def total_by_page
            total_collection = []
            @entry_collection.each do |e|
                unless total_collection.detect {|t| t["path"] == e.path }
                    total_collection << {"path" => e.path, "total_visits" => 1}
                else
                     total_collection.find{|entry| entry["path"] == e.path}["total_visits"] += 1
                end
            end

            sorted_totals = total_collection.sort_by{|path| path["total_visits"] }.reverse

            sorted_totals.each do |t|
                puts "Page #{t["path"]} was visited #{t["total_visits"]} times"
            end

            return total_collection
        end

        def unique_by_page
            total_collection = []
            summary_collection = []
            @entry_collection.each do |e|
                unless total_collection.detect {|t| (t["path"] == e.path) && (t["ip"] == e.ip)}
                    total_collection << {"path" => e.path, "ip" => e.ip, "total_visits" => 1}
                else
                    total_collection.find{|entry| (entry["path"] == e.path) && (entry["ip"] == e.ip)}["total_visits"] += 1
                end
            end

            total_collection.each do |e|
                unless summary_collection.detect {|t| t["path"] == e["path"]}
                    summary_collection << {"path" => e["path"], "total_unique_visits" => 1}
                else
                    summary_collection.find{|entry| entry["path"] == e["path"]}["total_unique_visits"] += 1
                end
            end

            sorted_totals = summary_collection.sort_by{|path| path["total_unique_visits"] }.reverse

            sorted_totals.each do |t|
                puts "Page #{t["path"]} was visited by #{t["total_unique_visits"]} unique visitors"
            end

            return summary_collection
        end

    end
end