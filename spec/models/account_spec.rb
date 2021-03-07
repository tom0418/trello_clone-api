# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'Account Validations' do
    it { is_expected.to(validate_presence_of(:email)) }
    it { is_expected.to(validate_presence_of(:password)) }
    it { is_expected.to(validate_presence_of(:nickname)) }
    it { is_expected.to(validate_presence_of(:uuid)) }
    it { is_expected.to(allow_value('example@example.com').for(:email)) }
    it { is_expected.to(allow_value('example@example.co.jp').for(:email)) }
    it { is_expected.not_to(allow_value('example').for(:email)) }
    it { is_expected.not_to(allow_value('example@example').for(:email)) }
    it { is_expected.to(validate_length_of(:password).is_at_least(8).is_at_most(128)) }
  end

  describe 'Account Associations' do
    it { is_expected.to(belong_to(:user)) }
  end
end
