class Admin::OrdersController < Admin::BaseController
  def index
    @studio = Studio.find(params[:studio])
    @orders = Order.associated_photos(@studio)
  end

  def show
    @studio = Studio.find(params[:studio])
    @order = Order.find(params[:id])
  end
end
