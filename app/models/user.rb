class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, :format => { :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :password, presence: true

  has_many :orders
  belongs_to :studio
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :user_photos
  has_many :photos, through: :user_photos

  def platform_admin?
    roles.exists?(name: "platform admin")
  end

  def customer?
    roles.exists?(name: "customer")
  end

  def studio_admin?
    roles.exists?(name: "studio admin")
  end

  def non_admin
    studio == nil && !platform_admin?
  end

  def relevent_studio_admin(query_studio)
    studio_admin? && platform_admin? == false && studio == query_studio
  end

  def delete_studio_admin_role
    self.user_roles.each do |user_role|
      if user_role.role.name == "studio admin"
        self.user_roles.find(user_role.id).delete
      end
    end
  end

  def pre_owned_photos?(cart)
    cart.cart_photos.each do |cart_photo|
      photos.each do |photo|
        if cart_photo == photo
          return true
        end
      end
    end
    false
  end
end
