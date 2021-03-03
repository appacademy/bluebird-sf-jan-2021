FactoryBot.define do
  factory :user do
    username { Faker::Movies::HarryPotter.character }
    age { 20 }
    email { Faker::Internet.email }
    password { 'password'}

    factory :harry_potter do 
      username { 'Harry Potter'}
    end 
  end
end
