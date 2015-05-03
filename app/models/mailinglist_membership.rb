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

class MailinglistMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :mailinglist

  def user_name
    user ? user.name : ''
  end
end
