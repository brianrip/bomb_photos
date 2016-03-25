require "rails_helper"

RSpec.feature "user places an order" do
  scenario "user places an order", js: true do
    category = create_category
    studio = create_studio
    user = create_user
    photo = create_studio_photo(studio, category)

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    visit root_path

    click_on "Example Category"
    click_on "Example Name"
    click_on "Add to Cart"

    visit cart_path

    click_on "Checkout"

    expect(current_path).to eq(new_order_path)
    expect(page).to have_content("Please complete your order")
    expect(page).to have_content(photo.name)
    expect(page).to have_content("9.99")
    expect(page).to have_css("img[src='#{photo.image}']")

    click_on "Pay with Card"
    page.execute_script("$('.$CardPayment.0.0').val('scottfirestone@gmail.com')")

    click_on "Pay"
    expect(page).to have_content("Your order is complete")
    expect(page).to have_content(order.total_price)
    # expect(page).to have_content(order.created_at)
  end
end
