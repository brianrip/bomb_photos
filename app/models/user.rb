class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true
  validates :password, presence: true

  has_many :orders
  has_many :order_gifs, through: :orders
  belongs_to :studio

  enum role: %w(default admin)
end
