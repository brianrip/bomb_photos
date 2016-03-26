require "test_helper"

class CartTest < ActiveSupport::TestCase
  test "add gif to cart increases contents" do
    category = Category.create(name: "Example Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0,
                           promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
    )

    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )
    cart = Cart.new([photo.id.to_s])

    assert_equal 1, cart.total_items

    photo2 = studio.photos.create(name:        "Example Name2",
                                 description: "Example Description2",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )
    cart.add_photo(photo2.id)

    photo3 = studio.photos.create(name:        "Example Name3",
                                 description: "Example Description3",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )
    cart.add_photo(photo3.id)

    assert_equal 3, cart.total_items
  end

  test "remove_gif removes gif from cart" do
    category = Category.create(name: "Example Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0,
                           promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
    )

    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )
    cart = Cart.new([photo.id.to_s])

    photo2 = studio.photos.create(name:        "Example Name2",
                                 description: "Example Description2",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )
    cart.add_photo(photo2.id)

    assert_equal 2, cart.total_items

    cart.remove_photo(photo2.id)

    assert_equal 1, cart.total_items
  end

  test "cartphotos method returns cartphoto objects" do

    category = Category.create(name: "Example Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0,
                           promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
    )

    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )
    cart = Cart.new([photo.id.to_s])

    photo2 = studio.photos.create(name:        "Example Name2",
                                 description: "Example Description2",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )
    cart.add_photo(photo2.id)

    assert_equal CartPhoto, cart.cart_photos.first.class
    assert_equal 2, cart.cart_photos.count
  end

  test "total price returns total price in cents" do
    category = Category.create(name: "Example Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0,
                           promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"

    )

    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )
    cart = Cart.new([photo.id.to_s])

    photo2 = studio.photos.create(name:        "Example Name2",
                                 description: "Example Description2",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )
    cart.add_photo(photo2.id)

    assert_equal 1998, cart.total_price
  end
end
