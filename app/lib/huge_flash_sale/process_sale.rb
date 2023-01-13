module HugeFlashSale
    class ProcessSale
        attr_reader :store_name, :model

        def self.process(event)
            new(event).broadcast_events
        end

        def initialize(event)
            json_event  = JSON.parse(event)
            @store_name = json_event['store']
            @model      = json_event['model']
            @inventory  = json_event['inventory']
        end

        def store
            @store ||= Store.find_or_create_by(name: @store_name)
        end

        def shoe
            @shoe ||= find_or_create_shoe
        end

        def suggestions_report
            SuggestionsReport.new.generate
        end

        def broadcast_events
            ActionCable.server.broadcast "shoe_events_channel", custom_event
            ActionCable.server.broadcast "suggestions_report_channel", suggestions_report
        end

        private

        def custom_event
            @custom_event ||= ShoeJsonBuilder.json_event(store, shoe)
        end

        def find_or_create_shoe
            shoe = store.shoes.find_or_create_by(model: @model.upcase)
            shoe.update_attribute(:inventory, @inventory)
            shoe
        end
    end
end
