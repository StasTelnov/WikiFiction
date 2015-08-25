FactoryGirl.define do
  factory :article do
    category      { Category.offset(rand(Category.count)).first }
    title         { Faker::Name.title }
    author        { Faker::Name.name }
    text          { Faker::Lorem.paragraph(100) }
    ip            { Faker::Internet.ip_v4_address }

    factory :article_with_comments do
      after(:create) do |article|
        rand(5..10).times { create(:comment, { :article => article }) }
      end
    end
  end
end
