class Admin::OrdersController < Admin::BaseController
  before_action :find_studio
  
  def index
    @orders = Order.joins(photos: :studio).where("studios.id = #{@studio.id}").distinct
  end

  def show
    @order = Order.find(params[:id])
  end
end
