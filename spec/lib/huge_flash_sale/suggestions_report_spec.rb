require 'rails_helper'

describe HugeFlashSale::SuggestionsReport do

    describe 'suggestions report' do
        before do
            @suggestinos_report = HugeFlashSale::SuggestionsReport.new
            @shoe_1 = create(:shoe, inventory: 1, model: 'test')
            @shoe_2 = create(:shoe, inventory: 80, model: 'test')
        end

        it 'should return low inventory shoes array' do
            lows = @suggestinos_report.lows
            expect(lows.count).to eql(1)
        end

        it 'should returnn high inventory shoes array' do
            lows = @suggestinos_report.lows
            expect(lows.count).to eql(1)
        end

        it 'should generate suggestions report' do
            report = @suggestinos_report.generate
            suggestion = report[0]
            
            expect(suggestion[:id]).to eql("#{suggestion[:low][:id]}#{suggestion[:high][:id]}")
            expect(suggestion[:low][:id]).to eql(@shoe_1.id)
            expect(suggestion[:low][:model]).to eql(@shoe_1.model)
            expect(suggestion[:low][:inventory]).to eql(@shoe_1.inventory)
            expect(suggestion[:low][:store][:name]).to eql(@shoe_1.store.name)

            expect(suggestion[:high][:id]).to eql(@shoe_2.id)
            expect(suggestion[:high][:model]).to eql(@shoe_2.model)
            expect(suggestion[:high][:inventory]).to eql(@shoe_2.inventory)
            expect(suggestion[:high][:store][:name]).to eql(@shoe_2.store.name)
        end
    end
end
