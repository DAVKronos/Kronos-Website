class MailinglistMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :mailinglist
  # attr_accessible :title, :body
end
