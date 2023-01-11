module HugeFlashSale
    module ShoeJsonBuilder
        def self.json_event(store, shoe)
            {
                id: "#{store.id}#{shoe.id}",
                store: {
                    id: store.id,
                    name: store.name
                },
                shoe: {
                    id: shoe.id,
                    model: shoe.model,
                    alert: shoe.alert,
                    inventory: shoe.inventory
                }
            }
        end
    end
end
