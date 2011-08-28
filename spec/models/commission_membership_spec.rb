require 'spec_helper'

describe CommissionMembership do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: commission_memberships
#
#  id            :integer         not null, primary key
#  function      :string(255)
#  installed     :boolean
#  user_id       :integer
#  commission_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

