# == Schema Information
# Schema version: 20110521143528
#
# Table name: users
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  initials      :string(255)
#  email         :string(255)
#  birthdate     :date
#  address       :string(255)
#  postalcode    :string(255)
#  city          :string(255)
#  sex           :string(255)
#  licensenumber :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class User < ActiveRecord::Base
  
  attr_accessible :name, :initials, :birthdate, :email, :address, :postalcode, :city, :sex, :licensenumber, :login, :password, :password_confirmation
  
  name_regex = /\A[A-Z][a-z]+\s([a-z]+\s([a-z]+\s)*)?[A-Z][a-z]*(-[A-Z][a-z]+)*\z/
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  acts_as_authentic do |config|
    config.crypto_provider = Authlogic::CryptoProviders::Sha512
  end
  
  validates :name, :presence => true,
                   :format => {:with => name_regex}
  
  validates :initials, :presence => true,
                       :format => {:with => /([A-Z][.])+/}
  
  validates :email, :presence => true,
                    :format => {:with => email_regex}
  
  validates :birthdate, :presence => true
  
  validates :postalcode, :presence => true
  
  validates :city, :presence => true
  
  validates :sex, :presence => true
  
  validates :address, :presence => true
  
end
