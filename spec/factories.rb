=begin
FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
=end

FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    
    factory :admin do
      admin true
    end
    
    factory :coadmin do
      coadmin true
    end
  end
  
  factory :post do
    title "Prueba"
    content "Lorem ipsum"
    user
  end

  
end


