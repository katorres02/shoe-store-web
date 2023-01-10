class Shoe < ApplicationRecord
    belongs_to :store, optional: false

    validates_presence_of :model
    validates_uniqueness_of :model, { case_sensitive: false }
    enum alert: { green: 0, white: 1, red: 2 }

    before_save :update_alert

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
