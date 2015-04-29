User.create!(name: 'Example User',
             email: 'example@example.com',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@example.com"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  title = Faker::Lorem.sentence
  excerpt = Faker::Lorem.paragraph
  content = Faker::Lorem.paragraph(3)
  tag_list = %w(Foo Bar Fizz Buzz).sample(2).join(', ')
  picture = File.open(Rails.root + "public/uploads/article/picture/#{%w(light coffee wire working writing).sample}.jpg")
  created_at = rand(2.years).seconds.ago
  users.each {|user| user.articles.create!(title: title,
                                           excerpt: excerpt,
                                           content: content,
                                           picture: picture,
                                           tag_list: tag_list,
                                           created_at: created_at)}
end
