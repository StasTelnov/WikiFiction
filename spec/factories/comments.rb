FactoryGirl.define do
  factory :comment do
    article       { Article.offset(rand(Article.count)).first }
    author        { Faker::Name.name }
    text          { Faker::Lorem.paragraph }
    rating        { (rand * 5).round(2) }
  end
end