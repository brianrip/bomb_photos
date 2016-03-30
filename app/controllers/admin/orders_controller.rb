class Admin::OrdersController < Admin::BaseController
  before_action :find_studio

  def index
    @orders = Order.studio_specific_orders(@studio)
  end

  def show
    @order = Order.find(params[:id])
  end
end
