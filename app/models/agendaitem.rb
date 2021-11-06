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
  before_update :change_reserve_status
  validates :name, :presence => true
  validates :name_en, :presence => true
  validates :agendaitemtype_id, :presence => true
  validates :description, :presence => true, unless: ->{description_en.nil? or description_en.empty?}
  validates :description_en, :presence => true, unless: ->{description.nil? or description.empty?}

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

  def change_reserve_status
    if self.subscribe && self.maxsubscription.present? and self.maxsubscription != self.maxsubscription_was
      previous_maxsub = self.maxsubscription_was.nil? ? self.subscriptions.count : self.maxsubscription_was

      if self.maxsubscription > previous_maxsub
        n = self.maxsubscription - previous_maxsub
        puts 'prev', previous_maxsub, n
        reserves = self.subscriptions.where(reserve: true).order(created_at: :asc).limit(n)
        reserves.each do |subscription|
          subscription.reserve= false
          subscription.save
        end
      else
        n = previous_maxsub - self.maxsubscription
        reserves = self.subscriptions.where(reserve: false).order(created_at: :desc).limit(n)
        reserves.each do |subscription|
          subscription.reserve= true
          subscription.save
        end
      end
    end
  end

end
