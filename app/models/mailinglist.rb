# == Schema Information
#
# Table name: mailinglists
#
#  id          :integer          not null, primary key
#  name        :text
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  local_part  :string(255)
#

class Mailinglist < ActiveRecord::Base
  before_save :add_mailinglist
  after_destroy :delete_mailinglist


  has_many :mailinglist_memberships, :dependent => :destroy

  has_many :users, :through => :mailinglist_memberships,
           :before_remove => :unsubscribe_from_mailinglist

  attr_accessible :description, :name, :local_part, :mailinglist_memberships_attributes, :user_ids

  accepts_nested_attributes_for :mailinglist_memberships, :allow_destroy => true

  validates :name, :presence => true
  validates :local_part, :presence => true, :format => {:with => /\A(\w)*\z/}


  def full_email
    self.local_part + '@kronos.nl'
  end

  private

  def add_mailinglist
    api_client = KronosGoogleAPIClient.new
    api_client.create_email_group(self.full_email, self.name, self.description)
  end

  def delete_mailinglist
    api_client = KronosGoogleAPIClient.new
    api_client.destroy_email_group(self.full_email)
  end

  def unsubscribe_from_mailinglist(user)
    api_client = KronosGoogleAPIClient.new
    api_client.remove_member_from_group(user, self.full_email)
  end




end