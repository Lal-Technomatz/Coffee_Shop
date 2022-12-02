class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.decimal :grand_total, precision: 10, scale: 2 


      t.timestamps
    end
  end
end
