module HugeFlashSale
    module ShoeJsonBuilder
        def self.json_event(store, shoe)
            {
                customId: "#{store.id}#{shoe.id}",
                id: shoe.id,
                model: shoe.model,
                alert: shoe.alert,
                inventory: shoe.inventory,
                store: {
                    id: store.id,
                    name: store.name
                }
            }
        end
    end
end
