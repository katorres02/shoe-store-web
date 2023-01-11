module HugeFlashSale
    class SuggestionsReport
        attr_reader :report

        def initialize
            @report = []
        end

        def lows
            @lows ||= Shoe.low_stock
        end

        def highs
            @highs ||= Shoe.big_stock_for(@lows.pluck(:model))
        end

        def generate
            lows.each do |x|
                match = highs.find { |y| x.model == y.model }

                @report << {
                    id: "#{x[:id]}#{match[:id]}",
                    low: ShoeJsonBuilder.json_event(x.store, x),
                    high: ShoeJsonBuilder.json_event(match.store, match)
                } if match
            end
            @report
        end
    end
end