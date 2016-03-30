class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_cart
  helper_method :current_user,            :current_studio_admin?,
                :current_platform_admin?, :format_price

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_studio_admin?
    current_user && current_user.studio_admin?
  end

  def require_correct_admin
    if (!current_platform_admin?) && (current_user.studio != @studio)
      flash[:danger] = "You can only edit a studio that belongs to you"
      render file: "/public/404"
    end
  end

  def current_platform_admin?
    current_user && current_user.platform_admin?
  end

  def find_photo
    @photo = Photo.find(params[:id])
  end

  def format_price(number)
    "$#{sprintf('%.2f', number.to_f/100.0)}"
  end
end
