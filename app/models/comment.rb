class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
end
# == Schema Information
#
# Table name: reactions
#
#  id            :integer         not null, primary key
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  user_id       :integer
#  agendaitem_id :integer
#  result_id     :integer
#  photo_id      :integer
#  newsitem_id   :integer
#  reactiontext  :text
#

