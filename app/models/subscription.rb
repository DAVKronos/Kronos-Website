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

class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :agendaitem
  attr_reader :user, :agendaitem
  before_create :set_reserve_status
  after_destroy :change_reserve_status

  # def initialize(user, agendaitem)
  #   @user, @agendaitem = user, agendaitem
  # end
  
  def detectUser(val)
    user = User.find_by_name(val)
    self[:user_id] = user.id if user
    self[:name] = val
  end

  def set_reserve_status
    agendaitem = Agendaitem.find(self.agendaitem_id)
    puts 'count', agendaitem.subscriptions.where(reserve: false).count
    if agendaitem.maxsubscription.present? and agendaitem.maxsubscription <= agendaitem.subscriptions.where(reserve: false).count
      self.reserve = true
    end
  end


  def change_reserve_status
    agendaitem = Agendaitem.find(self.agendaitem_id)
    if agendaitem.maxsubscription.present? and not self.reserve
      first_reserve = agendaitem.subscriptions.where(reserve: true).order(created_at: :asc).first
      puts 'first_reserve', first_reserve
      if first_reserve
        first_reserve.reserve = false
        first_reserve.save
      end
    end
  end
end
