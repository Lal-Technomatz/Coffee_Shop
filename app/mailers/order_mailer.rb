class OrderMailer < ApplicationMailer
  def send_order_mail(order)
    @order = order

    mail(to:"atomar@technomatz.com" ,from:"atomar@technomatz.com",subject:"#{@order.id}",message:"hello")
    
    # @view_context = view_context

    # invoice = OrderPdf.new(@order, @view_context)
    # attachments["invoice.pdf"] = { :mime_type => 'application/pdf', :content => invoice.render }
    # mail(to: @order.customer.customer_email ,from:"atomar@technomatz.com",subject:"#{@order.customer.customer_name}",message:"")
  end
end
