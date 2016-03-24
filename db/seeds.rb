class Seed
  def initialize
    @num_studios = 10
    @num_users = 50
    @num_categories = 5
    @num_photos = 100
    @num_orders = 100
    generate_studios
    generate_users
    generate_studio_admins
    generate_categories
    generate_photos
    generate_orders
  end

  def generate_studios
    @num_studios.times do
      Studio.create(name: Faker::Commerce.department, description: Faker::Lorem.sentence, status: 0)
    end
    puts "Generating studios"
  end

  def generate_users
    @num_users.times do
      User.create(email: Faker::Internet.email, password: "password", role: 0)
    end
    puts "Generating users"
  end

  def generate_studio_admins
    Studio.all.each do |studio|
      studio.users << User.create(email: Faker::Internet.email, password: "password", role: 1)
    end
    puts "generating studio admins"
  end

  def generate_categories
    @num_categories.times do
      Category.create(name: Faker::Lorem.word)
    end
    puts "generating categories"
  end

  def generate_photos
    @num_photos.times do
      studio = Studio.all.shuffle.pop
      studio.photos.create(name:        Faker::Lorem.word,
                           description: Faker::Lorem.sentence,
                           image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                           price:       Random.rand(1..1000),
                           category_id: Random.rand(1..@num_categories)
      )
    end
    puts "generated photos"
  end

  def generate_orders
    @num_orders.times do
      puts "generating an order"
      user = User.all.shuffle.pop
      order = user.orders.create(total_price: 1000)
      Random.rand(1..5).times do
        photo_id = Photo.all.shuffle.pop.id
        op = OrderPhoto.create(photo_id: photo_id)
        order.order_photos << op
      end
    end
  end
end

Seed.new
