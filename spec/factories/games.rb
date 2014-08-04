# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    title "MyString"
    console "MyString"
    ask_price 1.5
    condition "MyString"
    original_packaging false
    seller_id ""
  end
end
