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
#  adress        :string(255)
#  postalcode    :string(255)
#  city          :string(255)
#  sex           :string(255)
#  licensenumber :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class User < ActiveRecord::Base
end
