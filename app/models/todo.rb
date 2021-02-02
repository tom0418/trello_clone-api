# frozen_string_literal: true

# == Schema Information
#
# Table name: todos
#
#  id         :bigint           not null, primary key
#  memo       :text(65535)
#  title      :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Todo < ApplicationRecord
  validates :title, presence: true
  validates :memo, presence: true
end
