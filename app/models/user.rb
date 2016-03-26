class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, :format => { :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }

  validates :password, presence: true

  has_many :orders
  belongs_to :studio
  has_many :user_roles
  has_many :roles, through: :user_roles

  def platform_admin?
    roles.exists?(name: "platform admin")
  end

  def customer?
    roles.exists?(name: "customer")
  end

  def studio_admin?
    roles.exists?(name: "studio admin")
  end
end
