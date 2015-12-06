class Announcement < ActiveRecord::Base
  attr_accessible :title, :message, :ends_at, :starts_at, :url, :background
  has_attached_file :background, 
	  	    :styles      => {:back => "1170x"},
          :path        => ":rails_root/public/system/:attachment/:hash.:extension",
          :url         => "/system/:attachment/:hash.:extension", 
          :hash_secret => "longSecretString"

  def self.current(hidden_ids = nil)
    result = where("starts_at <= :now and ends_at >= :now", now: Time.zone.now)
    result = result.where("id not in (?)", hidden_ids) if hidden_ids.present?
    result
  end
end
