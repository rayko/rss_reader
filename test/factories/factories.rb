FactoryGirl.define do
  factory :test_user, :class => User do |user|
    user.first_name 'Lolcat'
    user.last_name 'McAlliester'
    user.username 'lolcat'
    user.email 'lolcat@example.com'
    user.password '123456789'
    user.password_confirmation '123456789'
    association :profile_type, :factory => :profile_type, :name => 'Basic', :channel_limit => 10
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

  factory :profile_type do |profile_type|
    profile_type.name 'Basic'
    profile_type.channel_limit 10
  end

  factory :channel do
    sequence :name do |n|
      "Channe_#{n}"
    end
    sequence :url do |n|
      "htt://mspaintadventures.com/rss/rss.xml.#{n}"
    end
  end
end
