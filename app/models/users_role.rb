# frozen_string_literal: true

# == Schema Information
#
# Table name: users_roles
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_users_roles_on_role_id              (role_id)
#  index_users_roles_on_user_id              (user_id)
#  index_users_roles_on_user_id_and_role_id  (user_id,role_id)
#
# Foreign Keys
#
#  fk_users_roles_roles1  (role_id => roles.id)
#  fk_users_roles_users1  (user_id => users.id)
#
class UsersRole < ApplicationRecord
  belongs_to :user
  belongs_to :role
end
