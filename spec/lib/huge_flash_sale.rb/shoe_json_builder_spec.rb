require 'rails_helper'

describe HugeFlashSale::ShoeJsonBuilder do
    describe 'json serializer' do
        it 'should return valid json structur' do
            store = create(:store)
            shoe = create(:shoe, store: store)
            json = HugeFlashSale::ShoeJsonBuilder.json_event(store, shoe)

            expected_json ={
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

            expect(json).to eql(expected_json)
        end
    end
end
