class PlatformAdmin::OrdersController < PlatformAdmin::BaseController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end
end
