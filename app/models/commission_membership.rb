# == Schema Information
#
# Table name: commission_memberships
#
#  id            :integer          not null, primary key
#  function      :string(255)
#  installed     :boolean          default(FALSE)
#  user_id       :integer          not null
#  commission_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CommissionMembership < ActiveRecord::Base
  after_save :add_member_to_group
  before_destroy :remove_member_from_group

  belongs_to :user
  belongs_to :commission
  
  validates :user_id,       :presence => true
  validates :function,      :presence => true
  
  has_paper_trail
  
  def add_member_to_group
    gapps = KronosGoogleAPIClient.new
    gapps.add_member_to_group(self.user, self.commission.email)
  end
  
  def remove_member_from_group
    gapps = KronosGoogleAPIClient.new
    gapps.remove_member_from_group(self.user, self.commission.email)
  end
  
  def update_commission_email(old_email)
    gapps = KronosGoogleAPIClient.new
    gapps.remove_member_from_group(self.commission.email, User.new(:email => old_email))
    gapps.add_member_to_group(self.commission.email, self.user)
  end
    
  

end
