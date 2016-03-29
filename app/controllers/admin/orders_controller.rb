class Admin::OrdersController < Admin::BaseController
  def index
    @studio = Studio.find(params[:studio])
    @orders = Order.joins(photos: :studio).where("studios.id = #{@studio.id}").distinct

  end

  def show
    @studio = Studio.find(params[:studio])
    @order = Order.find(params[:id])
  end
end
