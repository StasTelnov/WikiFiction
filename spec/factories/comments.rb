FactoryGirl.define do
  factory :comment do
    article       { Article.random_record }
    author        { Faker::Name.name }
    text          { Faker::Lorem.paragraph }
    rating        { (rand * 5).round(2) }
  end

end