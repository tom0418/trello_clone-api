# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  role_type_id :bigint           not null
#
class Role < ApplicationRecord
  enum role_type_id: {
    admin: 0,
    management: 1,
    member: 2
  }

  has_many :users_roles, dependent: :delete_all
  has_many :users, through: :users_roles
  validates :role_type_id, presence: true
end
