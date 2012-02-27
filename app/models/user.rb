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
#  created_at          :datetime
#  updated_at          :datetime
#

class User < ActiveRecord::Base
    acts_as_authorization_subject  :association_name => :roles, :join_table_name => :roles_users
    acts_as_authorization_object join_table_name: "roles_users"
  
    attr_accessible :email, :address, :postalcode, 
                      :city, :password, :password_confirmation, 
                      :papieren_kronometer, :avatar, :avatar_file_name

    attr_accessible :name, :initials, :birthdate,
                      :sex, :licensenumber, :password,
                      :password_confirmation, :papieren_kronometer,
                      :avatar, :avatar_file_name,:email,
                      :address, :postalcode, :city, :login, :as => :bestuur
  
  has_many :commission_memberships, :dependent => :destroy
  has_many :commissions, :through => :commission_memberships
  has_many :chatmessages
  has_many :results
  has_many :subscriptions
  has_many :newsitems
  has_many :tags
  has_many :pages
  has_attached_file :avatar, :styles => { :medium => "300x300", :pass => "260x180#" }
  
  name_regex = /\A[A-Z][a-z]+\s([a-z]+\s([a-z]+\s)*)?[A-Z][a-z]*(-[A-Z][a-z]+)*\z/
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  acts_as_authentic do |config|
    config.crypto_provider = Authlogic::CryptoProviders::Sha512
  end
  
  validates :name, :presence => true,
                   :format => {:with => name_regex}
  
  validates :initials, :presence => true,
                       :format => {:with => /\A([A-Z][.])+\z/}
  
  validates :email, :presence => true,
                    :format => {:with => email_regex}
  
  validates :birthdate, :presence => true
  
  validates :postalcode, :presence => true
  
  validates :city, :presence => true
  
  validates :sex, :presence => true
  
  validates :address, :presence => true
  
end


