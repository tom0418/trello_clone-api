# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  first_name             :string(255)      default(""), not null
#  image                  :string(255)
#  last_name              :string(255)      default(""), not null
#  nickname               :string(255)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  include EmailUtils
  PASSWORD_LENGTH = (8..128).freeze

  has_many :users_roles, dependent: :delete_all
  has_many :roles, through: :users_roles

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  validates :email, presence: true, format: { with: EmailUtils::EMAIL_REGEX }, uniqueness: { case_sensitive: false }, if: :email_required?
  validates :password, presence: true, length: { in: PASSWORD_LENGTH }, if: :password_required?
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :nickname, presence: true
end
