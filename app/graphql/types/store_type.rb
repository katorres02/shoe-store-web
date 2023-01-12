module Types
    class StoreType < Types::BaseObject
        field :id, ID, null: false
        field :name, String, null: false
        field :shoes, [Types::ShoeType], null: true

        def shoes
            BatchLoader::GraphQL.for(object.id).batch(default_value: []) do |store_ids, loader|
                Shoe.where(store_id: store_ids).each do |shoe|
                    loader.call(shoe.store_id) { |shoes| shoes << shoe }
                end
            end
        end
    end
end
