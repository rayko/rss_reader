FactoryGirl.define do
  factory :test_user, :class => User do |user|
    user.first_name 'Lolcat'
    user.last_name 'McAlliester'
    user.username 'lolcat'
    user.email 'lolcat@example.com'
    user.password '123456789'
    user.password_confirmation '123456789'
  end


  factory :generic_user, :class => User do |user|
    user.first_name 'User'
    user.last_name 'Test'
    sequence :username do |n|
      "user_#{n}"
    end
    sequence :email do |n|
      "user_#{n}@example.com"
    end
    user.password '123456789'
    user.password_confirmation '123456789'
  end
end
