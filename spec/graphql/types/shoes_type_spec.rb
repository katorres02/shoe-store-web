require 'rails_helper'

describe Types::ShoeType do
    describe 'shoes query' do
        it 'should returnn a collection of shoes' do
            shoe = create(:shoe)
            query = <<-GRAPHQL
            {
              shoes {
                customId
                id
                model
                inventory
                alert
                store {
                  id
                  name
                }
              }
            }
            GRAPHQL

            result = ShoeStoreWebSchema.execute(query, variables: nil, context: nil)
            expect(result['data']['shoes'][0]['id']).to eql(shoe.id.to_s)
            expect(result['data']['shoes'][0]['model']).to eql(shoe.model.to_s)
            expect(result['data']['shoes'][0]['inventory']).to eql(shoe.inventory)
            expect(result['data']['shoes'][0]['alert']).to eql(shoe.alert.to_s)
            expect(result['data']['shoes'][0]['store']['id']).to eql(shoe.store.id.to_s)
        end
    end
end
