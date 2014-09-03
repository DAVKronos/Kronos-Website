# == Schema Information
#
# Table name: subscriptions
#
#  id            :integer          not null, primary key
#  comment       :text
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#  agendaitem_id :integer
#

class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :agendaitem
  
  def detectUser(val)
    user = User.find_by_name(val)
    self[:user_id] = user.id if user
    self[:name] = val
  end
end
