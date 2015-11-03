# == Schema Information
#
# Table name: commissions
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  email       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  role        :string(255)
#

class Commission < ActiveRecord::Base
  before_save :add_commission_email
  after_destroy :destroy_commission_email

  has_many :commission_memberships, :dependent => :destroy
  has_many :users, :through => :commission_memberships
  has_many :agendaitems
  has_many :mailinglists
  
  accepts_nested_attributes_for :commission_memberships, :allow_destroy => true
  
  has_paper_trail

  def add_commission_email
#    gapps = KronosGoogleAPIClient.new
#    gapps.create_email_group(self.email, self.name, self.description)
  end

  def destroy_commission_email
#    gapps = KronosGoogleAPIClient.new
#    gapps.destroy_email_group(self.email)
  end
end
