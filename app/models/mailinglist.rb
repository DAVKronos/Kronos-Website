class Mailinglist < ActiveRecord::Base
  has_many :mailinglist_memberships

  attr_accessible :description, :name


end
