require 'rails_helper'

describe Types::SuggestionReportType do
    describe 'suggestion report query' do
        it 'should returnn a collection of suggestions to move inventory' do
            shoe_1 = create(:shoe, inventory: 0, model: 'ONE')
            shoe_2 = create(:shoe, inventory: 90, model: 'ONE')
            query = <<-GRAPHQL
            {
              suggestionsReport{
                id
                low
                high
              }
            }
            GRAPHQL

            result = ShoeStoreWebSchema.execute(query, variables: nil, context: nil)
            low_json  = HugeFlashSale::ShoeJsonBuilder.json_event(shoe_1.store, shoe_1)
            high_json = HugeFlashSale::ShoeJsonBuilder.json_event(shoe_2.store, shoe_2)
            expect(result['data']['suggestionsReport'][0]['id']).to eql("#{shoe_1.id}#{shoe_2.id}")
            expect(result['data']['suggestionsReport'][0]['low']).to eql(low_json)
            expect(result['data']['suggestionsReport'][0]['high']).to eql(high_json)
        end
    end
end
