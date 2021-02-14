# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  nickname               :string(255)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  uuid                   :string(255)      default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint
#
# Indexes
#
#  index_accounts_on_confirmation_token    (confirmation_token) UNIQUE
#  index_accounts_on_email                 (email) UNIQUE
#  index_accounts_on_reset_password_token  (reset_password_token) UNIQUE
#  index_accounts_on_user_id               (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_accounts_users1  (user_id => users.id)
#
class Account < ApplicationRecord
  include AuthToken
  include EmailUtils

  PASSWORD_LENGTH = (8..128).freeze

  belongs_to :user

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :confirmable

  validates :email, presence: true, format: { with: EmailUtils::EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { in: PASSWORD_LENGTH }, confirmation: true
  validates :nickname, presence: true
  validates :uuid, presence: true
end
