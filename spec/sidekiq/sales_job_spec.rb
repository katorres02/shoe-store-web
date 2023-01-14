require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe SalesJob, type: :job do
  it 'should process sales event using HugeFlashSales module' do
    args = {}
    expect(HugeFlashSale::ProcessSale).to receive(:process).with(args).once
    SalesJob.perform_async(args)
  end
end
