FactoryBot.define do
  factory :item_order do
    user_id           {nil}
    item_id           {nil}
    postal_code       {"100-0014"}
    place_id          {14}
    city              {"千代田区"}
    address           {"永田町1丁目7-1"}
    building          {"2階"}
    phone_number      {"030000"}
    token             {"testtoken"}
  end
end
