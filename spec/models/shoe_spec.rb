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
end
