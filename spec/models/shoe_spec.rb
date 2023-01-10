require 'rails_helper'

describe Shoe, :type => :model do
    describe 'validations' do
        subject { build(:shoe) }
        it { should validate_presence_of :model }
        it { should validate_uniqueness_of(:model).case_insensitive }
    end

    describe 'relations' do
        it { should belong_to(:store) }
    end

    describe 'alerts' do
        it 'should update alert when invetory goes down' do
            shoe = create(:shoe, inventory: 50, alert: false)
            expect(shoe.inventory).to eql(50)
            expect(shoe.alert).to be_falsey

            shoe.update(inventory: 6)
            expect(shoe.inventory).to eql(6)
            expect(shoe.alert).to be_truthy
        end
    end
end
