class OrdersController < ApplicationController
	before_action :set_order, only: %i[ show edit update destroy ]

	# GET /items or /items.json
	def index
		@orders = Order.all
	end

	# GET /items/1 or /items/1.json
	def show
	end

	# GET /items/new
	def new
		@order = Order.new
		@order.order_items.build
    @discount = Discount.all
	end

	# GET /items/1/edit
	def edit
	end

	# POST /items or /items.json
	def create
    dis_order_items = {}
		@order = Order.new(order_params)
    order_items = @order.order_items
    order_items.each do |oi|
      discount = Discount.find_by(base_item_id: oi.item_id)
      if discount.present? && oi.quantity >= discount.base_item_quantity
				nub_of_tym_dis_applied = oi.quantity / discount.base_item_quantity
        dis_order_items[discount.child_item_id] = [discount.id, nub_of_tym_dis_applied]
      end
			total = oi.item.price * oi.quantity
			tax = (oi.item.tax_category.tax_rate.to_f * total ) / 100
			oi.tax_value = tax
      oi.total_price = total
    end
    if dis_order_items.present?
      dis_order_items.each do |item_id, discount_data|
				
				order_item = order_items.select { |oi| oi.item_id == item_id }.first
				discount, discount_multiplier = discount_data
				dis_data = Discount.find(discount)
				discount_quantity = dis_data.child_item_quantity
				total_quantity = order_item.quantity
        remaining_quantity = total_quantity - (discount_quantity*discount_multiplier)
        remaining_order_item_total = order_item.item.price * remaining_quantity
        d_order_item_total = order_item.item.price * discount_quantity * dis_data.discount_percent/100
				tax = (order_item.item.tax_category.tax_rate.to_f * remaining_order_item_total ) / 100 
				order_item.tax_value = tax
				order_item.total_price = remaining_order_item_total
        dis_order_items.clear()
      end
    end

		respond_to do |format|
			if @order.save
				OrderMailer.send_order_mail(@order).deliver_later!(wait: 1.minutes)
        format.html { redirect_to order_url(@order), notice: "Order was successfully Created." }
			else
				format.html { render :new, status: :unprocessable_entity }
				format.json { render json: @order.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /items/1 or /items/1.json
	def update
		dis_order_items = {}
    order_items = @order.order_items
    order_items.each do |oi|
      discount = Discount.find_by(base_item_id: oi.item_id)
      if discount.present? && oi.quantity >= discount.base_item_quantity
				nub_of_tym_dis_applied = oi.quantity / discount.base_item_quantity
        dis_order_items[discount.child_item_id] = [discount.id, nub_of_tym_dis_applied]
      end
			total = oi.item.price * oi.quantity
			tax = (oi.item.tax_category.tax_rate.to_f * total ) / 100
			oi.tax_value = tax
      oi.total_price = total
    end
    if dis_order_items.present?
      dis_order_items.each do |item_id, discount_data|
				
				order_item = order_items.select { |oi| oi.item_id == item_id }.first
				discount, discount_multiplier = discount_data
				dis_data = Discount.find(discount)
				discount_quantity = dis_data.child_item_quantity
				total_quantity = order_item.quantity
        remaining_quantity = total_quantity - (discount_quantity*discount_multiplier)
        remaining_order_item_total = order_item.item.price * remaining_quantity
        d_order_item_total = order_item.item.price * discount_quantity * dis_data.discount_percent/100
				tax = (order_item.item.tax_category.tax_rate.to_f * remaining_order_item_total ) / 100 
				order_item.tax_value = tax
				order_item.total_price = remaining_order_item_total
        dis_order_items.clear()
      end
    end
		respond_to do |format|
			if @order.update(order_params)	
				format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
				format.json { render :show, status: :ok, location: @order }
			else
				format.html { render :edit, status: :unprocessable_entity }
				format.json { render json: @order.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /items/1 or /items/1.json
	def destroy
		@order.destroy

		respond_to do |format|
			format.html { redirect_to orders_url, notice: "Item was successfully destroyed." }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_order
			@order = Order.find(params[:id])
		end

		# Only allow a list of trusted parameters through.
		def order_params
			params.require(:order).permit(order_items_attributes: OrderItem.attribute_names.map(&:to_sym).push(:destroy))
		end


end
