FactoryGirl.define do
  factory :post do
    author "Henry Remache"
    text "Ruby is awesome and Rspec is great!"
    category_id {[FactoryGirl.create(:category)]}
  end
end
