# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

return unless Rails.env.development?

puts("Seeding data...")

Message.destroy_all
Inbox.destroy_all
User.destroy_all

%w[test1@test.com test2@test.com].each do |email|
  # faker_email = Faker::Internet.email
  user = User.create(email: email, password: '123456')

  rand(2..3).times do 
    faker_name = Faker::GreekPhilosophers.quote   # Faker::Lorem.question(word_count: 5)
    inbox = Inbox.create(name: faker_name, user: user)

    rand(2..5).times do 
      message_body = Faker::Marketing.buzzwords  #Faker::Lorem.paragraph
      Message.create(body: message_body, inbox: inbox, user: user)
    end
  end

end

p "#{User.count} users created"
p "#{Inbox.count} inboxes created"
p "#{Message.count} messages created"
