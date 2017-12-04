# This file should conta455803in all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



10.times do
  x = Faker::Pokemon.name
  User.create(
    username: x,
    email: Faker::Internet.email(x + rand(10).to_s),
    password: "password",
    password_confirmation: "password"
  )
end


User.all.each do |user|
  20.times do
    user.posts.create(
      title: Faker::Pokemon.move,
      body:  Faker::RickAndMorty.quote
    )
  end
end


User.all.each do |user|
  x = User.all
  10.times do
    user.sent_friend_requests.create(requestee: x.sample,
                                      accepted: true)
    user.sent_friend_requests.create(requestee: x.sample,
                                      accepted: false)

  end
end
