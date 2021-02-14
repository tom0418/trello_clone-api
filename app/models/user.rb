# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  first_name :string(255)      default(""), not null
#  icon       :string(255)
#  last_name  :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_one :account, dependent: :destroy
  has_many :users_roles, dependent: :delete_all
  has_many :roles, through: :users_roles

  validates :first_name, presence: true
  validates :last_name, presence: true
end
