class Order < ApplicationRecord
	# belongs_to :item
	has_many :order_items, inverse_of: :order, dependent: :destroy
	accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: :all_blank
	has_many :items, through: :order_items, dependent: :destroy
	after_save :save_grand_total

	# calculate save_grand_total
	def save_grand_total
    tax = order_items.sum(:tax_value)
    total = order_items.sum(:total_price)
    sum = tax + total
		return if grand_total == sum
    tax = order_items.sum(:tax_value)
    total = order_items.sum(:total_price)
    sum = tax + total
		update(grand_total: sum)
	end
end
