# == Schema Information
#
# Table name: mailinglist_memberships
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  mailinglist_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe MailinglistMembership do
  # pending "add some examples to (or delete) #{__FILE__}"
end
