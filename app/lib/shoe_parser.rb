class ShoeParser
    attr_reader :store_name, :model

    def self.process(event)
        new(event).save
    end

    def initialize(event)
        json_event = JSON.parse(event.data)
        @store_name = json_event['store']
        @model = json_event['model']
        @inventory = json_event['inventory']
    end

    def store
        @store ||= Store.find_or_create_by(name: @store_name)
    end

    def shoe
        @shoe ||= find_or_create_shoe
    end

    def save
        shoe
    end

    private

    def find_or_create_shoe
        shoe = store.shoes.find_or_create_by(model: @model)
        shoe.update_attribute(:inventory, @inventory)
        shoe
    end
end
