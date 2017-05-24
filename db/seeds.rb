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

# Create admin user
user = User.new(
  email: 'admin@master.com',
  password: 'password',
  password_confirmation: 'password',
  role: 2
)
user.skip_confirmation!
user.save!

users = User.all

# Create Wikis
50.times do
  content = %Q{### Hello world!

    The list of things to do:

    * write more wikis
    * edit this wikis maker
    * code more

  Checkout this article about AlphaGo from the NYT [nytimes.com](https://www.nytimes.com/2017/05/23/business/google-deepmind-alphago-go-champion-defeat.html?hpw&rref=technology&action=click&pgtype=Homepage&module=well-region&region=bottom-well&WT.nav=bottom-well)}
  wiki = Wiki.new(
    user: users.sample,
    title: Faker::Lorem.unique.sentence,
    body: Faker::Lorem.paragraph(6) + content
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
