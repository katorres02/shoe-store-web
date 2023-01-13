require 'rails_helper'

describe HugeFlashSale::ProcessSale do
    let(:event) { "{\"store\":\"ALDO Solomon Pond Mall\",\"model\":\"WUMA\",\"inventory\":\82\}" }
    let(:sale) { HugeFlashSale::ProcessSale.new(event) }

    it 'should respond to store_name, model' do
        expect(sale.store_name).to eql('ALDO Solomon Pond Mall')
        expect(sale.model).to eql('WUMA')
    end

    describe 'store' do
        it 'should create store if it doesn"t exist' do
            expect(Store.count).to eql(0)
            sale.store
            expect(Store.count).to eql(1)
            expect(Store.first.name).to eql('ALDO Solomon Pond Mall')
        end
    end

    describe 'shoe' do
        it 'should create shoe if it doesn"t exist' do
            expect(Shoe.count).to eql(0)
            sale.shoe
            expect(Shoe.count).to eql(1)
            expect(Shoe.first.model).to eql('WUMA')
        end
    end

    describe 'suggestions_report' do
        it 'should call SuggestionsReport class and generate a report' do
            expect_any_instance_of(HugeFlashSale::SuggestionsReport).to receive(:generate).and_return([])
            expect(sale.suggestions_report).to eql([])
        end
    end

    describe 'broadcast_events' do
        it 'should use action cable to broadcast events' do
            expect(ActionCable.server).to receive(:broadcast).twice
            sale.broadcast_events
        end
    end
end
