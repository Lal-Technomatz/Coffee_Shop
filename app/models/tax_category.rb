class TaxCategory < ApplicationRecord
    has_many :items, dependent: :destroy
end
