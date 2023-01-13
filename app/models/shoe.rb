class Shoe < ApplicationRecord
    belongs_to :store, optional: false

    validates_presence_of :model
    validates_uniqueness_of :model, { case_sensitive: false, scope: :store_id }
    enum alert: { green: 0, white: 1, red: 2 }

    before_save :update_alert

    def self.low_stock
        self.where(alert: 'red').includes(:store)
    end

    def self.big_stock_for(model_name)
        self.where(model: model_name, alert: 'green').includes(:store)
    end

    private

    def update_alert
        if self.inventory < 15
            self.alert = :red
        elsif self.inventory > 70
            self.alert = :green
        else
            self.alert = :white
        end
    end
end
