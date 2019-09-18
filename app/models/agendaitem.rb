# == Schema Information
#
# Table name: agendaitems
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  description          :text
#  date                 :datetime
#  location             :string(255)
#  subscribe            :boolean
#  subscriptiondeadline :datetime
#  commission_id        :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  category             :string(255)
#  intern               :boolean
#  agendaitemtype_id    :integer
#  url                  :string(255)
#  user_id              :integer
#

class Agendaitem < ApplicationRecord
  belongs_to :commission
  has_many :photoalbums
  has_many :events, :dependent => :destroy
  has_many :subscriptions, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :agendaitemtype
  belongs_to :user
  accepts_nested_attributes_for :events, :allow_destroy => true
  accepts_nested_attributes_for :subscriptions, :allow_destroy => true
  accepts_nested_attributes_for :comments, :reject_if => :all_blank
  validates_associated :events

  def count_results()
    counter = 0
    self.events.each do |ev|
      counter += ev.results.count
    end
    return counter
  end

  def self.search(search,limit)
    if search
      where(['name LIKE ?', "%#{search}%"]).order("date(date) DESC").limit(limit).select("id, name, date")
    else
      order("date(date) DESC").limit(limit).select("id, name, date")
    end
  end

  def self.rangeMonth(date)
    where(date: date.beginning_of_month..date.end_of_month)
  end

  def get_url_name()
    if self.url
      if self.url.length > 40
        return self.url[0..37] + "..."
      else
        return self.url
      end
    else
      return ""
    end
  end
  
  def get_url()
    if self.url
      if self.url.index("/") == 0
        return self.url
      elsif self.url["http://"]
        return self.url
      elsif self.url["https://"]
        return self.url
      else
        return "http://" + self.url
      end
    else
      return "#"
    end
  end

  def deadline_passed?()
    return ((self.subscriptiondeadline - Time.now) <= 0)
  end

end
