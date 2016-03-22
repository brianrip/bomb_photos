class Seeds

  def initialize
    create_users
    create_studio_admin
    create_platform_admin
    create_categories
    create_studios
    create_active_photos
    @num_users = 10
    @num_categories = 10
    @num_studios = 3
    @num_photos = 1000
    @num_orders = 100
  end

  def create_users
    @num_users.times do
      User.create(email: Faker::Internet.email, password: "password")
    end
  end

  def create_studio_admin
    User.create(email: Faker::Internet.email, password: "password", role: 1)
  end

  def create_platform_admin
    User.create(email: Faker::Internet.email, password: "password", role: 2)
  end

  def create_categories
    @num_categories.times do
      Category.create(name: Faker::Commerce.department)
    end
  end

  def create_studios
    @num_studios.times do
      Studio.create(name: Faker::Company.name)
    end
  end

  def create_active_photos
    @num_photos.times do
      Photo.create(name: Faker::Commerce.product_name,
                   description: Faker::Lorem.paragraph,
                   category: Category.find(Random.new.rand(1..@num_categories)),
                   price: Random.rand(2000..100000),
                   studio: Studio.find(Random.new.rand(1..@num_studios),
                   image: Faker::Avatar.image,
                   status: 0)
    end
  end

  def create_orders
    @num_orders.times do
      user = User.find(Random.new.rand(1..@num_users))
      order = user.orders.create!
      add_photos_to_order(order)
    end
  end

  def add_photos_to_order(order)
    10.times do
      photo = Photo.find(Random.new.rand(1..@num_photos))
      order.photos << photo
    end
  end
end
