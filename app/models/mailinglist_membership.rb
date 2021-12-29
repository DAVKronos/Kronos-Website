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

class MailinglistMembership < ApplicationRecord
  after_save :subscribe_to_mailinglist
  after_destroy :unsubscribe_from_mailinglist
  belongs_to :user
  belongs_to :mailinglist

  def subscribe_to_mailinglist
    if Rails.env.production?
      api_client = KronosGoogleAPIClient.new
      api_client.add_member_to_group(self.user, self.mailinglist.full_email)
    end
  end


  def unsubscribe_from_mailinglist
    if Rails.env.production?
      api_client = KronosGoogleAPIClient.new
      api_client.remove_member_from_group(self.user, self.mailinglist.full_email)
    end
  end

end
