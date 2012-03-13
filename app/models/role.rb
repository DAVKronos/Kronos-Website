class Role < ActiveRecord::Base
  acts_as_authorization_role join_table_name: "roles_users"
end
# == Schema Information
#
# Table name: roles
#
#  id                :integer         not null, primary key
#  name              :string(40)
#  authorizable_type :string(40)
#  authorizable_id   :integer
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#

