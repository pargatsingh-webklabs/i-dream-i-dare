FactoryGirl.define do
  factory :mentorship do
    client 1
    coach 1
  end
  factory :message do
    from 1
    to 1
    content "MyText"
  end
  factory :user do
    
  end
end
