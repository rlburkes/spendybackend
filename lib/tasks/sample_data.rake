namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Randy Burkes",
                 email: "rlburkes@gmail.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)
    
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    
    users = User.all(limit: 6)
    50.times do
      amount = (200.0 - 5.0) * rand() + 5
      users.each { |user| user.expenses.create!(amount: amount) }
    end
  end
end