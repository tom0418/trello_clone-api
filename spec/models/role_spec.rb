# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'Role validations' do
    it { is_expected.to(validate_presence_of(:role_type_id)) }
  end

  describe 'Role associations' do
    it { is_expected.to(have_many(:users)) }
    it { is_expected.to(have_many(:users_roles).dependent(:delete_all)) }
  end
end
