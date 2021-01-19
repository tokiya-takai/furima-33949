FactoryBot.define do
  factory :item do
    random = Random.new
    title           {Faker::Lorem.sentence}
    content         {Faker::Lorem.sentence}
    category_id      {2}
    status_id        {2}
    delivery_id      {2}
    place_id         {2}
    duration_id      {2}
    price            {random.rand(300..9999999)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
