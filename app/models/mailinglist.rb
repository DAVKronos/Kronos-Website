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

class Mailinglist < ApplicationRecord
  before_create :add_mailinglist
  after_destroy :delete_mailinglist

  has_many :mailinglist_memberships, :dependent => :destroy
  has_many :mailinglists,
           :before_add => :subscribe_mailinglist_to_mailinglist,
           :before_remove => :unsubscribe_mailinglist_from_mailinglist

  has_many :users, :through => :mailinglist_memberships,
           :before_remove => :unsubscribe_from_mailinglist

  has_and_belongs_to_many :aliases, 
                          :before_add => :subscribe_alias_to_mailinglist,
                          :before_remove => :unsubscribe_alias_from_mailinglist

  belongs_to :commission

  accepts_nested_attributes_for :mailinglist_memberships, :allow_destroy => true

  validates :name, :presence => true
  validates :local_part, :presence => true, :format => {:with => /\A(\w)*\z/}

  def full_email
    self.local_part + '@kronos.nl'
  end

  def get_possible_users
    if self.commission.nil?
      return User.joins(:user_type).order('user_types.name', :name)
    else
      return self.commission.users.joins(:user_type).order('user_types.name', :name) | self.users
    end
  end

  private

  def add_mailinglist
    if Rails.env.production?
        Rails.logger.info "Creating email group with email: #{self.full_email}, name: #{self.name}, description: #{self.description}"
        begin
        api_client = KronosGoogleAPIClient.new
        result = api_client.create_email_group(self.full_email, self.name, self.description)
        Rails.logger.info "Google API response: #{result}"
        rescue => e
          Rails.logger.error "Google API error: #{e.message}"
          raise
        end
    end
  end

  def delete_mailinglist
    if Rails.env.production?
      api_client = KronosGoogleAPIClient.new
      api_client.destroy_email_group(self.full_email)
    end
  end

  def subscribe_maillinglist_to_mailinglist(mailinglist)
    if Rails.env.production?
      api_client = KronosGoogleAPIClient.new
      api_client.add_group_to_group(mailinglist, self.full_email)
    end
  end

  def unsubscribe_mailinglist_from_mailinglist(mailinglist)
    if Rails.env.production?
      api_client = KronosGoogleAPIClient.new
      api_client.remove_group_from_group(mailinglist, self.full_email)
    end
  end

  def subscribe_alias_to_mailinglist(alia)
    if Rails.env.production?
      api_client = KronosGoogleAPIClient.new
      api_client.add_alias_to_group(alia, self.full_email)
    end
  end

  def unsubscribe_alias_from_mailinglist(alia)
    if Rails.env.production?
      api_client = KronosGoogleAPIClient.new
      api_client.remove_alias_from_group(alia, self.full_email)
    end
  end

  def unsubscribe_from_mailinglist(user)
    if Rails.env.production?
      api_client = KronosGoogleAPIClient.new
      api_client.remove_member_from_group(user, self.full_email)
    end
  end
end
