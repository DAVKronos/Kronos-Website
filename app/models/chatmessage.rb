# == Schema Information
#
# Table name: chatmessages
#
#  id         :integer          not null, primary key
#  by         :string(255)
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string(255)
#  user_id    :integer
#  user_ip    :string(255)
#  user_agent :string(255)
#  referrer   :string(255)
#

class Chatmessage < ActiveRecord::Base
  include Rakismet::Model
  after_save :spam_check
  attr_accessible :by, :message, :email
  belongs_to :user
  validates_presence_of :by, :message, :email
  rakismet_attrs :author => :by, :author_email => :email, :content => :message
  
  def spam_check
    if self.spam?
      self.destroy
    end
  end
  
  handle_asynchronously :spam_check
  
  def request=(request)
    self.user_ip    = request.remote_ip
    self.user_agent = request.env['HTTP_USER_AGENT']
    self.referrer   = request.env['HTTP_REFERER']
  end
end
