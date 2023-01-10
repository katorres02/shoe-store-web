require 'rails_helper'

describe Store, :type => :model do
    describe 'validations' do
        subject { build(:store) }
        it { should validate_presence_of :name }
        it { should validate_uniqueness_of(:name).case_insensitive }
    end
end
