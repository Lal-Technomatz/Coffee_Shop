class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order
  validates :quantity, presence: true, length: { minimum: 1 }
  # before_save :Update_total_price, :calculate_tax
  

  # def Update_total_price
  #   self.total_price = item.price * quantity
  # end

  # def calculate_tax
  #   self.tax_value = total_price * item.tax_category.tax_rate/100
  # end

end
