require 'test_helper'

class PlatformAdminSeesOrdersTest < ActionDispatch::IntegrationTest

  test "platform admin sees orders index" do
    category = create_category
    studio = create_studio
    other_studio = Studio.create(name:        "Other Studio",
                           description: "Other example description.",
                           status:      0,
                           promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
    )
    admin = studio.users.create(email:  "admin@eample.com",
                                password: "password",
                                )
    admin.roles << customer_role
    admin.roles << studio_admin_role
    admin.roles << platform_admin_role
    admin
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    user = create_user
    other_user = other_studio.users.create(email:  "otherexample@eample.com",
                                           password: "password",
                                          )
    other_user.roles << customer_role

    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       1000,
                                 category_id: category.id
    )

    photo2 = other_studio.photos.create(name:        "Example2 Name",
                                 description: "Example2 Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       1000,
                                 category_id: category.id
    )

    order = create_order(user, photo)
    order2 = create_order(other_user, photo)

    order_photo3 = OrderPhoto.create(photo_id: photo2.id)
    order2.order_photos << order_photo3

    visit platform_admin_orders_path
    assert page.has_content?(order2.id)
    assert page.has_content?(order.id)
  end

  test "platform admin sees individual order" do
    category = create_category
    studio = create_studio
    other_studio = Studio.create(name:        "Other Studio",
                           description: "Other example description.",
                           status:      0,
                           promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
    )
    admin = studio.users.create(email:  "admin@eample.com",
                                password: "password",
                                )
    admin.roles << customer_role
    admin.roles << studio_admin_role
    admin.roles << platform_admin_role
    admin
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    user = create_user
    other_user = other_studio.users.create(email:  "otherexample@eample.com",
                                           password: "password",
                                          )
    other_user.roles << customer_role

    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       1000,
                                 category_id: category.id
    )

    photo2 = other_studio.photos.create(name:        "Example2 Name",
                                 description: "Example2 Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       1000,
                                 category_id: category.id
    )

    order = create_order(user, photo)
    order2 = create_order(other_user, photo)

    order_photo3 = OrderPhoto.create(photo_id: photo2.id)
    order2.order_photos << order_photo3

    visit platform_admin_orders_path
    click_on(order2.id)
    assert page.has_css?("img[src='#{order2.photos.first.image}']")
    assert page.has_content?(other_user.email)
    assert page.has_content?(order2.format_total_price)
  end
end
