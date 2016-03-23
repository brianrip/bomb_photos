10.times do
  Tag.create(name: Faker::Hipster.word)
end
#
71.times do
  gif = Gif.create(title: Faker::Lorem.sentence,
              description: " adfg",
              price: 100,
              image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
              )
  gif.tags << Tag.all.shuffle.first
end


20.times do
  subtotal = Random.new.rand(1..10)
  user = User.create(username: "string", password: "password")
  gif = Gif.all.shuffle.first
  order = user.orders.create!(total_price: 3*subtotal)
  order.order_gifs.create!(
    gif_id: gif.id, quantity: 1, subtotal: subtotal
  )
  gif = Gif.all.shuffle.first
  order.order_gifs.create!(
    gif_id: gif.id, quantity: 2, subtotal: subtotal*2
  )
end




Charity.create(name: "Colorado Coalition Against Sexual Assault", description: "The Colorado Coalition Against Sexual Assault (CCASA) is a membership organization promoting safety, justice and healing for survivors while working toward the elimination of sexual violence.", logo: "http://www.ccasa.org/wp-content/uploads/2015/02/logo2.png")
Charity.create(name: "Phoenix Multisport", description: 'Phoenix Multisport fosters a supportive, physically active community for individuals who are recovering from alcohol and substance abuse and those who choose to live a sober life. Through pursuits such as climbing, hiking, running, strength training, yoga, road/mountain biking, socials and other activities, we seek to help our members develop and maintain the emotional strength they need to stay sober.', logo: "https://www.phoenixmultisport.org/images/pms_logo.png")
Charity.create(name: "Deworm the World Initiative", description: 'Part of Evidence Action, Deworm the World Initiative is ranked as a top charity at GiveWell. A large body of evidence shows that eradicating intestinal worms in children is one of the potential biggest vectors for change in strugging communities. "Intestinal worms are debilitating, widespread, and under-treated. School-based deworming is safe, cost-effective and scale-able."', logo: "https://give.evidenceaction.org/uploads/4/3/9/6/43962849/1448300461.png")
