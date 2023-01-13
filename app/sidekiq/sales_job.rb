class SalesJob
  include Sidekiq::Job

  sidekiq_options queue: 'flash_sales'

  def perform(args)
    HugeFlashSale::ProcessSale.process(args)
  end
end
