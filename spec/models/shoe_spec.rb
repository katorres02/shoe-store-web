require 'rails_helper'

describe Shoe, :type => :model do
    describe 'validations' do
        subject { build(:shoe) }
        it { should validate_presence_of :model }
        it { should validate_uniqueness_of(:model).scoped_to(:store_id).case_insensitive }
    end

    describe 'relations' do
        it { should belong_to(:store) }
    end

    describe 'alerts' do
        it 'should update alert when invetory goes down' do
            shoe = create(:shoe, inventory: 50, alert: false)
            expect(shoe.alert).to eql("white")

            shoe.update(inventory: 1)
            expect(shoe.alert).to eql("red")

            shoe.update(inventory: 80)
            expect(shoe.alert).to eql("green")
        end
    end
end
