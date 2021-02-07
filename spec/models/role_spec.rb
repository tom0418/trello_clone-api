# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'Role validations' do
    it { is_expected.to(validate_presence_of(:role_type_id)) }
  end
end
