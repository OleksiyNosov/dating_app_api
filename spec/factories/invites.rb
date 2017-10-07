FactoryGirl.define do
  factory :invite do
    event
    user
    respond { %i[no_respond attend not_attend].sample }
  end
end
