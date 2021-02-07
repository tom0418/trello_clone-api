# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User Validations' do
    it { is_expected.to(validate_presence_of(:email)) }
    it { is_expected.to(validate_presence_of(:password)) }
    it { is_expected.to(validate_presence_of(:name)) }
    it { is_expected.to(validate_presence_of(:nickname)) }
    it { is_expected.to(validate_presence_of(:provider)) }
    it { is_expected.to(validate_presence_of(:uid)) }
    it { is_expected.to(allow_value('example@example.com').for(:email)) }
    it { is_expected.to(allow_value('example@example.co.jp').for(:email)) }
    it { is_expected.not_to(allow_value('example').for(:email)) }
    it { is_expected.not_to(allow_value('example@example').for(:email)) }
    it { is_expected.to(validate_length_of(:password).is_at_least(8).is_at_most(128)) }
  end

  describe 'User Associations' do
    it { is_expected.to(have_many(:users_roles).dependent(:delete_all)) }
  end
end
