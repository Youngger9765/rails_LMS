FactoryBot.define do
  factory :quiz do
    
  end

  factory :exercise do
    
  end

  factory :admin_section, class: 'Admin::Section' do
    
  end

  factory :admin_course, class: 'Admin::Course' do
    
  end

  factory :admin_classroom, class: 'Admin::Classroom' do
    
  end

  factory :admin_school, class: 'Admin::School' do
    
  end

  factory :classroom_student_ship do
    
  end

  factory :student do
    name { Faker::Team.name }
    age { rand(3..80) }
    city { Faker::Team.name }
    school_name { Faker::Team.sport }
    school_type { Faker::Team.sport }
    grade { rand(1..12) }
  end

  factory :user do
    email { Faker::Internet.email }
    password { "12345678" }
    password_confirmation { "12345678" }
  end

  factory :school do
    name { Faker::Team.name}
    description { Faker::Team.sport }
    is_public {[true, false].sample}
  end

end