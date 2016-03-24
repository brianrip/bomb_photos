class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(slug: params[:slug])
  end

  def index
    @categories = Category.alpha
  end
end
