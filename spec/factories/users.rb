# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_id         :string(255)      not null
#  first_name      :string(255)      not null
#  last_name       :string(255)
#  employee_number :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :user do
    sequence(:id) { |n| rand(5) + n }
    sequence(:user_id) { |n| "uid#{n}" }
    first_name 'John'
    last_name 'Smith'
    sequence(:employee_number) { |n| rand(1000) + n }
  end
end
