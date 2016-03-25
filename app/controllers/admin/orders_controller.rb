class Admin::OrdersController < Admin::BaseController
  def index
    @studio = Studio.find(params[:studio])
    @orders = Order.associated_photos(@studio)
  end

  def update
    @order = Order.find(params[:id])
    @order.update(status: params[:status].to_i)
    flash[:success] = "You have successfully updated Order#{@order.id} as #{@order.status}"
    redirect_to admin_orders_path
  end

  def show
    @studio = Studio.find(params[:studio])
    @order = Order.find(params[:id])
  end
end
