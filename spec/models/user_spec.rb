# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User Validations' do
    it { is_expected.to(validate_presence_of(:first_name)) }
    it { is_expected.to(validate_presence_of(:last_name)) }
  end

  describe 'User Associations' do
    it { is_expected.to(have_one(:account).dependent(:destroy)) }
    it { is_expected.to(have_many(:users_roles).dependent(:delete_all)) }
  end
end
