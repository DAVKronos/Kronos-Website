class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
    
    before_save :purge_member_from_group, :update_group_membership, :update_commission_email
    after_destroy :remove_member_from_group
  
    attr_accessible :email, :address, :postalcode, 
                      :city, :phonenumber, :password, :password_confirmation, 
                      :papieren_kronometer, :avatar, :avatar_file_name, :remember_me

    attr_accessible :name, :initials, :birthdate,
                      :sex, :licensenumber, :password,
                      :password_confirmation, :papieren_kronometer,
                      :avatar, :avatar_file_name,:email,
                      :address, :postalcode, :city, :phonenumber, :as => :bestuur
  
  has_many :commission_memberships, :dependent => :destroy
  has_many :commissions, :through => :commission_memberships
  has_many :chatmessages
  has_many :results
  has_many :subscriptions
  has_many :newsitems
  has_many :tags
  has_many :pages
  has_many :reactions
  has_attached_file :avatar, :styles => { :medium => "300x300", :pass => "260x180#", :thumb => "50x50#" }, :path => ":rails_root/public/system/:attachment/:hash.:extension",
  :url => "/system/:attachment/:hash.:extension", :hash_secret => "longSecretString"
  
  name_regex = /\A[A-Z].+\s(.+\s(.+\s)*)?[A-Z].*(-[A-Z].+)*\z/
  
  validates :name, :presence => true,
                   :format => {:with => name_regex}
  
  validates :initials, :presence => true
  
  validates :birthdate, :presence => true
  
  validates :postalcode, :presence => true
  
  validates :city, :presence => true
  
  validates :sex, :presence => true
  
  validates :address, :presence => true
  
  def update_group_membership
    gapps = Gapps.new
    gapps.add_group_member("leden2", self.email, self.name.split[1], self.name.split[0]) if self.email_changed? && !self.email.empty?
  end
  
  def purge_member_from_group
     gapps = Gapps.new
     gapps.destroy_group_member("leden2", self.email_was) if self.email_changed? && !self.new_record?
   end
  
  def remove_member_from_group
    gapps = Gapps.new
    gapps.destroy_group_member("leden2", self.email)
  end
  
  def update_commission_email
    if self.email_changed?
      self.commission_memberships.each do |commem|
        commem.update_commission_email(self.email_was, self.email)
      end
    end
  end
  
  def admin?
    self.commissions.include?(Commission.find_by_name('bestuur'))
  end
  
  
end


# == Schema Information
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  initials            :string(255)
#  email               :string(255)
#  birthdate           :date
#  address             :string(255)
#  postalcode          :string(255)
#  city                :string(255)
#  sex                 :string(255)
#  licensenumber       :string(255)
#  login               :string(255)     not null
#  persistence_token   :string(255)     not null
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer         default(0), not null
#  failed_login_count  :integer         default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  papieren_kronometer :boolean         default(FALSE)
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  admin               :boolean         default(FALSE)
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

