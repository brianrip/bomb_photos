class OrdersController < ApplicationController
  around_action :wrap_in_transaction, only: :create

  def index
    if current_user
      @orders = current_user.orders
    else
      render file: "/public/404"
    end
  end

  def show
    if Order.find(params[:id]).user == current_user
      @order = Order.find(params[:id])
    else
      render file: "/public/404"
    end
  end

  def new
    if current_user && current_user.pre_owned_photos?(@cart)
      flash[:danger] = "You have already purchased one of the photos in your cart. Please go back and remove it, unless you would like to purchase it again."
    end
    if current_user
      @order = Order.new
      @cart_photos = @cart.cart_photos
      render :new
    else
      flash[:info] = "You must log in or register to place an order."
      redirect_to login_path
    end
  end

  def create
    if current_user
      @user = current_user
      @order = OrderProcessor.new(@cart, @user).process_order
      session[:cart].clear
      flash[:success] = "Your order has been placed."
      redirect_to order_path(@order)
    else
      render file: "/public/404"
    end
  end

private

  def wrap_in_transaction
    ActiveRecord::Base.transaction do
      begin
        yield
      end
    end
  end
end
