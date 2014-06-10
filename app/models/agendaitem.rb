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
#

class Agendaitem < ActiveRecord::Base
  belongs_to :commission
  has_many :photoalbums
  has_many :events, :dependent => :destroy
  has_many :subscriptions, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :agendaitemtype
  accepts_nested_attributes_for :events, :allow_destroy => true
  accepts_nested_attributes_for :subscriptions, :allow_destroy => true
  accepts_nested_attributes_for :comments, :reject_if => :all_blank
  validates_associated :events
  
  def allow_edit?(user)
    if user
      user.commissions.each do |commission|
        if (commission.id == self.commission_id)
          return true
        end
      end
    else
      return false
    end
  end
  
  def allow_destroy?(user)
    if user
      user.commissions.each do |commission|
        if (commission.id == self.commission_id)
          return true
        end
      end
    else
      return false
    end
  end
  
  def count_results()
    counter = 0
    self.events.each do |ev|
      counter += ev.results.count
    end
    return counter
  end

  def self.search(search,limit)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"],:order => "date(date) DESC",:limit=>limit,:select => "id, name, date")
    else
      find(:all,:limit=>limit,:select => "id, name, date",:order => "date(date) DESC")
    end

  end

  def get_url_name()
    if self.url.length > 40
      return self.url[0..37] + "..."
	else
	  return self.url
	end
  end
  
  def get_url()
    if self.url.index("/") == 0
		return self.url
    elsif self.url["http://"]
		return self.url
	elsif self.url["https://"]
		return self.url
	else
	    return "http://" + self.url
	end
  end

  def deadline_passed?()
    return ((self.subscriptiondeadline - Time.now) <= 0)
  end

end
