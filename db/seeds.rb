class Seed
  def initialize
    @num_studios = 10
    @num_users = 50
    @num_photos = 20
    @num_orders = 100
    generate_studios
    generate_users
    generate_studio_admins
    generate_categories
    generate_photos
    generate_orders
    generate_studio_admins
    generate_studio_admin
    generate_platform_admin
  end

  def customer_role
    Role.create(name: "customer")
  end

  def studio_admin_role
    Role.create(name: "studio admin")
  end

  def platform_admin_role
    Role.create(name: "platform admin")
  end

  def generate_studios
    @num_studios.times do
      Studio.create(name: Faker::App.name, description: Faker::Lorem.sentence, status: 0, promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png")
    end
    puts "Generating studios"
  end

  def generate_users
    @num_users.times do
      user = User.create(email: Faker::Internet.email, password: "password")
      user.roles << customer_role
    end
    puts "Generating users"
  end

  def generate_studio_admins
    Studio.all.each do |studio|
      user = User.create(email: Faker::Internet.email, password: "password", studio_id: studio.id)
      user.roles << studio_admin_role
    end
    puts "generating studio admins"
  end

  def generate_studio_admin
    user = User.create(email: "example@example.com", password: "password", studio_id: 1)
    user.roles << studio_admin_role
  end

  def generate_platform_admin
    user = Studio.last.users.create(email: "platformadmin@example.com", password: "password", studio_id: 2)
    user.roles << platform_admin_role
    user.roles << studio_admin_role
    user.roles << customer_role
  endgit

  def generate_platform_only_admin
    user = Studio.last.users.create(email: "platformadmin@example.com", password: "password")
    user.roles << platform_admin_role
  end

  def generate_categories
    @categories = ["Nature", "Food", "Travel", "People", "Commerce"]
    @categories.each do |category|
      Category.create(name: category)
    end
    puts "generating categories"
  end

  def generate_photos
    @num_photos.times do
      puts "generated photos"
      studio = Studio.all.shuffle.pop
      studio.photos.create(name:        Faker::Lorem.word,
                           description: Faker::Lorem.sentence,
                           image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                           price:       Random.rand(1..1000),
                           category_id: Random.rand(1..@categories.length)
                           )
    end
  end

  def generate_orders
    @num_orders.times do
      subtotal = Random.rand(1..10)
      puts "generating an order"
      user = User.all.shuffle.pop
      order = user.orders.create(total_price: subtotal)
      Random.rand(1..5).times do
        photo_id = Photo.all.shuffle.pop.id
        UserPhoto.create(user_id: user.id, photo_id: photo_id)
        op = OrderPhoto.create(photo_id: photo_id)
        order.order_photos << op
      end
    end
  end
end

Seed.new
