# Create Users
10.times do
  user = User.new(
    username: Faker::Ancient.unique.god,
    email: Faker::Internet.email(Faker::LordOfTheRings.unique.character),
    password: 'password',
    password_confirmation: 'password'
  )
  user.skip_confirmation!
  user.save!
end

# Create admin user
user = User.new(
  username: 'Master',
  email: 'admin@master.com',
  password: 'password',
  password_confirmation: 'password',
  role: 2
)
user.skip_confirmation!
user.save!

# Create premium user
user = User.new(
  username: 'Premo',
  email: 'premium@money.com',
  password: 'password',
  password_confirmation: 'password',
  role: 1
)
user.skip_confirmation!
user.save!

users = User.all

# Create Wikis
30.times do
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

# Create Private wiki with collaborators
content = %Q{### Hello world!

  The list of things to do:

  * write more wikis
  * edit this wikis maker
  * code more

Checkout this article about AlphaGo from the NYT [nytimes.com](https://www.nytimes.com/2017/05/23/business/google-deepmind-alphago-go-champion-defeat.html?hpw&rref=technology&action=click&pgtype=Homepage&module=well-region&region=bottom-well&WT.nav=bottom-well)}
wiki = Wiki.new(
  user: users.last,
  title: Faker::Lorem.unique.sentence,
  body: content,
  private: true
)
wiki.save!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
