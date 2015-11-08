FactoryGirl.define do
  factory :message do
    user_id 1
mail_provider_id "MyString"
from "MyString"
to "MyString"
subject "MyString"
body "MyText"
originated_at "2015-11-07 21:31:52"
  end

end
