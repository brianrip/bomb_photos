class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all.select do |order|
      order.order_photos.any? do |order_photo|
        order_photo.photo.studio == current_user.studio
      end
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update(status: params[:status].to_i)
    flash[:success] = "You have successfully updated Order#{@order.id} as #{@order.status}"
    redirect_to admin_orders_path
  end

  def show
    @order = Order.find(params[:id])
  end
end
