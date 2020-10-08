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
#  studie                 :string(255)
#  instelling             :string(255)
#  aanvang                :integer
#

class User < ApplicationRecord
            # Include default devise modules.
            include DeviseTokenAuth::Concerns::User
            before_create :skip_confirmation!
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable


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
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :name, :presence => true
  validates :initials, :presence => true
  validates :birthdate, :presence => true
  validates :postalcode, :presence => true
  validates :city, :presence => true
  validates :sex, :presence => true
  validates :address, :presence => true
  # Dit vereenvoudigt de callback functies voor de maillijst
  validates :email, :presence => true
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  
  has_paper_trail :ignore => [:created_at, :updated_at, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip]
  
  def admin?
    self.commissions.each do |com|
      if com.role == 'ADMIN'
        return true
      end
    end
    # voor backwards compatibility
    self.commissions.exists?(Commission.find_by_name('Bestuur')&.id) or self.commissions.exists?(Commission.find_by_name('Webcie')&.id)
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
    return (bday - Date.today).to_i
  end

  def first_name
    self.name.split[0]
  end

  def last_name
    self.name.split[1]
  end

  def allowed_user_types
    if (self.admin?)
      return UserType.all
    elsif ([1,2,8].include? self.user_type_id)
      return UserType.where(:id => [1,2,8])
    else
      return UserType.where(:id => self.user_type_id)
    end
  end

  def allowed_users(user_type_id)
    allowed_ids = self.allowed_user_types.map(&:id)
    print allowed_ids
    print user_type_id.present? && allowed_ids.include?(user_type_id)
    print "howdyhi test shizzle" 
    if (user_type_id.present? && allowed_ids.include?(user_type_id))
      return User.where(:user_type_id => user_type_id)
    elsif self.admin?
      return User.all
    else 
      return User.where(:user_type_id => allowed_ids)
    end
  end

  def avatar_url_normal
    self.avatar.url(:normal)
  end

  def avatar_url_thumb
    self.avatar.url(:thumb)
  end

end
