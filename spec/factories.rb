FactoryGirl.define do
  factory :group_message do
    group_id 1
    from 1
    content "MyString"
  end
  # factory :group do
    
  # end
  factory :group_message do
    
  end
  factory :group_membership do
    user_id 1
    group_id "MyString"
    invited_by 1
  end
  # factory :group do
  #   name "MyString"
  #   created_by 1
  #   type ""
  # end
  factory :admin_message do
    from_name "MyString"
    from_email "MyString"
    content "MyText"
  end
  factory :plan do
    client 1
    title "MyString"
    content "MyText"
  end
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
