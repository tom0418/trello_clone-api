# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Todo, type: :model do
  subject { todo }

  let!(:todo) { build(:todo) }

  describe 'Validations' do
    it { is_expected.to(validate_presence_of(:title)) }
  end
end
