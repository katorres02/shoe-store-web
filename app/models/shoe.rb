class Shoe < ApplicationRecord
    belongs_to :store, optional: false

    validates_presence_of :model
    validates_uniqueness_of :model, { case_sensitive: false }

    before_save :update_alert

    private

    def update_alert
        alert = inventory > 20
    end
end
