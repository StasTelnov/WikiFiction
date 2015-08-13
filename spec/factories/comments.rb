FactoryGirl.define do
  factory :comment do
    article       { Article.random_record }
    author        { Faker::Name.name }
    text          { Faker::Lorem.paragraph }
    rating        { Faker::Number.between(1, 5) }
  end

end