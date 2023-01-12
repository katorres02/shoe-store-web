module Types
    class ShoeType < Types::BaseObject
        field :id, ID, null: false
        # custom id used by react key identifiers
        field :custom_id, String, null: false
        field :model, String, null: false
        field :inventory, Int, null: false
        field :alert, String, null: false
        field :store, Types::StoreType, null:false

        def custom_id
            "#{object.store_id}#{object.id}"
        end

        def store
            BatchLoader::GraphQL.for(object.store_id).batch do |store_ids, loader|
                Store.where(id: store_ids).each do |store|
                    loader.call(store.id, store)
                end
            end
        end
    end
end
