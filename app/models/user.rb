# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  initials               :string(255)
#  email                  :string(255)      default(""), not null
#  birthdate              :date
#  address                :string(255)
#  postalcode             :string(255)
#  city                   :string(255)
#  sex                    :string(255)
#  licensenumber          :string(255)
#  papieren_kronometer    :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  phonenumber            :string(255)
#  user_type_id           :integer
#  bank_account_number    :string(255)
#  xtracard               :string(255)
#  iban                   :string(255)
#

class User < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :purge_member_from_group, :update_commission_email

  after_destroy :remove_member_from_group

  after_save :add_member_to_group

  attr_accessible :name, :initials, :birthdate,
                  :sex, :licensenumber, :user_type_id,
                  :xtracard, :bank_account_number, :iban, :as => :bestuur


  attr_accessible :email, :address, :postalcode, :studie, :aanvang,
                  :instelling, :city, :phonenumber, :password,
                  :password_confirmation, :papieren_kronometer, :avatar,
                  :avatar_file_name, :remember_me, :as => [:default, :bestuur]
                  
  
  has_many :commission_memberships, :dependent => :destroy
  has_many :commissions, :through => :commission_memberships
  has_many :chatmessages
  has_many :results
  has_many :subscriptions
  has_many :newsitems
  has_many :tags
  has_many :agendaitems
  belongs_to :user_type
  has_attached_file :avatar, :styles => {:medium => "300x300", :pass => "260x180#", :thumb => "50x50#"},
                    :path => ":rails_root/public/system/:attachment/:hash.:extension",
                    :url => "/system/:attachment/:hash.:extension", :hash_secret => "longSecretString"

  name_regex = /\A[A-Z]\w+(-[A-Z]\w+)*\s(\w+\s)*[A-Z]\w+(-[A-Z]\w+)*\z/

  validates :name, :presence => true, :format => {:with => name_regex}
  validates :initials, :presence => true
  validates :birthdate, :presence => true
  validates :postalcode, :presence => true
  validates :city, :presence => true
  validates :sex, :presence => true
  validates :address, :presence => true
  # Dit vereenvoudigt de callback functies voor de maillijst
  validates :email, :presence => true

  
  has_paper_trail :ignore => [:created_at, :updated_at, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip]
  
  def admin?
    self.commissions.each do |com|
      if com.role == 'ADMIN'
        return true
      end
    end
    # voor backwards compatibility
    self.commissions.exists?(Commission.find_by_name('Bestuur')) or self.commissions.exists?(Commission.find_by_name('Webcie'))
  end

  def uitslagen_admin?
    self.commissions.each do |com|
      if com.role == 'RESULT_ADMIN'
        return true
      end
    end
    false
  end

  def kronometer_admin?
    self.commissions.each do |com|
      if com.role == 'KRONOMETER_ADMIN'
        return true
      end
    end
    false
  end

  def active?
    self.commissions.size > 0
  end

  def oudlid?
    if self.user_type
      self.user_type.name == 'Oudlid'
    else
      false
    end
  end

  def days_until_birthday
    bday = Date.new(Date.today.year, birthdate.month, birthdate.day)
    bday += 1.year if Date.today >= bday
    (bday - Date.today).to_i
  end

  def first_name
    self.name.split[0]
  end

  def last_name
    self.name.split[1]
  end
end
