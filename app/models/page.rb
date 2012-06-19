class Page < ActiveRecord::Base
end
# == Schema Information
#
# Table name: pages
#
#  id          :integer         not null, primary key
#  information :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  pagetag     :string(255)
#  user_id     :integer
#

