# Create Users
10.times do
  user = User.new(
    email: Faker::Internet.email(Faker::LordOfTheRings.unique.character),
    password: 'password',
    password_confirmation: 'password'
  )
  user.skip_confirmation!
  user.save!
end
# Create premium user
user = User.new(
  email: 'premium@money.com',
  password: 'password',
  password_confirmation: 'password',
  role: 1
)
user.skip_confirmation!
user.save!

users = User.all

# Create Wikis
50.times do
  wiki = Wiki.new(
    user: users.sample,
    title: Faker::Lorem.unique.sentence,
    body: Faker::Lorem.paragraph(6) + Faker::Lorem.paragraph(6)
  )
  wiki.save!
end

wiki = Wiki.new(
  user: users.last,
  title: Faker::Lorem.unique.sentence,
  body: Faker::Lorem.paragraph(6) + Faker::Lorem.paragraph(6),
  private: true
)
wiki.save!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
