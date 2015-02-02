FactoryGirl.define do
  factory :user, class: User do
    username { Faker::Internet.user_name('asdsad') } 
    email { Faker::Internet.email } 
    password  { Faker::Internet.password(8) } 
    admin false
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    username { Faker::Internet.user_name('admin') } 
    email { Faker::Internet.email('admin') } 
    password  { Faker::Internet.password(8) } 
    admin true
  end

  factory :contact do |c| 
    c.name { Faker::Name.name } 
    c.addr { Faker::Address.city }
    c.phone_number '08989898989'
    c.created_at { Faker::Time.between(2.days.ago, Time.now) }
    c.updated_at { Faker::Time.between(2.days.ago, Time.now) }
    user
  end

  factory :invalid_contact, parent: :contact do |i| 
    i.name nil 
    i.phone_number nil
  end

  factory :phone do |p|
    p.more_phone '08987878787'
    contact
  end

  factory :invalid_phone, parent: :contact do |p|
    p.more_phone '12345'
  end
end