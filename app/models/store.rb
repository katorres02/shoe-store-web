class Store < ApplicationRecord
    has_many :shoes

    validates_presence_of :name
    validates_uniqueness_of :name, { case_sensitive: false }
end
