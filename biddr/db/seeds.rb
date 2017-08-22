# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = 'supersecret'

Auction.destroy_all
Bid.destroy_all
User.destroy_all

User.create(
  first_name: 'Ainkaran',
  last_name: 'Pathmanathan',
  email: 'pat.ainkaran@gmail.com',
  is_admin: true,
  password: PASSWORD
)

10.times do
  # first_name = Faker::Name.first_name
  # last_name = Faker::Name.last_name
  user = Faker::StarWars.character
  email = user.delete(' ').downcase
  names = user.split(' ')

  User.create(
    first_name: names.first,
    last_name: names.last,
    email: "#{user.downcase.gsub(' ', '')}@example.com",
    password: PASSWORD,
    password_confirmation: PASSWORD
  )
end

users = User.all

100.times do
  p = Auction.create(
    title: Faker::Superhero.name,
    details: Faker::Hipster.sentence,
    price: Faker::Commerce.price,
    end_date: Faker::Date.between(2.days.ago, Date.today),
    user: users.sample
  )

  if p.persisted?
    10.times do
      p.bids.create(
        price: Faker::Number.decimal(2),
        current_price: Faker::Number.decimal(2),
        user: users.sample
      )
    end
  end
end

auctions = Auction.all
bids = Bid.all

puts "#{Auction.count} auctions created!"
puts "#{User.count} users created!"
puts "#{Bid.count} bids created!"
