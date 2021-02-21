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

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :confirmable, authentication_keys: [:login]

  validates :email, presence: true, format: { with: EmailUtils::EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { in: PASSWORD_LENGTH }, if: :password_required?
  validates :nickname, presence: true
  validates :uuid, presence: true
  validate :validate_nickname
  validate :validate_authentication_keys

  attr_writer :login

  def login
    @login || email || nickname
  end

  # https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    if login
      where(conditions.to_h).find_by(['lower(nickname) = :value OR lower(email) = :value', { value: login.downcase }])
    elsif conditions.key?(:nickname) || conditions.key?(:email)
      find_by(conditions.to_h)
    end
  end

  private

  # Validate case nickname same as others' email or others' nickname
  def validate_nickname
    accounts_with_nickname = Account.where.not(id: id).where.not(nickname: nil)
    errors.add(:nickname, :taken) if accounts_with_nickname.exists?(nickname: nickname) || Account.where.not(id: id).exists?(email: nickname)
  end

  def validate_authentication_keys
    errors.add(:nickname, :required) if email.blank? && nickname.blank?
  end

  # Copy from https://github.com/heartcombo/devise/blob/master/lib/devise/models/validatable.rb#L60
  # Because we won't use devise validatable anymore
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
