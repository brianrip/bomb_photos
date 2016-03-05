class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_gifs
  has_many :gifs, through: :order_gifs
end
