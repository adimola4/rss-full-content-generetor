FactoryBot.define do
    factory :rss do
      sequence(:title) { |n| "#{Faker::Book.title}#{n}" }
      sequence(:original_url) { "http://rss.cnn.com/rss/cnn_topstoriesss.rss" }
      sequence(:generated_url) { |n| "#{Faker::Internet.url}#{n}" }
      description { Faker::Lorem.paragraph }
      img_url { Faker::Internet.url }
      isready { false }
  
      # association :user, factory: :user
      # association :article, factory: :article
    end
  end
  