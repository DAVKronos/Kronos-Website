class CommissionMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :commission
  before_save :add_member_to_group
  after_destroy :remove_member_from_group
  
  validates :commission_id, :presence => true
  validates :user_id,       :presence => true
  validates :function,      :presence => true
  
  def add_member_to_group
    gapps = Gapps.new
    gapps.add_group_member(self.commission.email.split("@").first, self.user.email, self.user.name.split[1], self.user.name.split[0])
  end
  
  def remove_member_from_group
    gapps = Gapps.new
    gapps.destroy_group_member(self.commission.email.split("@").first, self.user.email)
  end
  
  def update_commission_email(oldEmail, email)
    gapps = Gapps.new
    gapps.destroy_group_member(self.commission.email.split("@").first, oldEmail)
    gapps.add_group_member(self.commission.email.split("@").first, email, self.user.name.split[1], self.user.name.split[0])
  end
    
  

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

