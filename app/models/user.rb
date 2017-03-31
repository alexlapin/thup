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

class User < ApplicationRecord
  validates_numericality_of :employee_number, :allow_blank => false
  validates_presence_of :user_id, :first_name
  validates_length_of :user_id, maximum: 80
  validates_length_of :first_name, maximum: 80
  validates_length_of :last_name, maximum: 80

  default_scope { order(created_at: :desc) }
  scope :ordered_by_first_name, -> { reorder(first_name: :asc) }
  scope :ordered_by_first_name2, -> { order(first_name: :asc).unscope(:order) }

  #User.ordered_by_first_name equal User.order(fist_name: :desc))
end
