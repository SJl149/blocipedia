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
users = User.all

# Create Wikis
50.times do
  wiki = Wiki.new(
    user: users.sample,
    title: Faker::Lorem.unique.sentences,
    body: Faker::Lorem.paragraphs + Faker::Lorem.paragraphs
  )
  wiki.save!
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
