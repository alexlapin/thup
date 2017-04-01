class UserSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :first_name, :last_name, :employee_number
end
