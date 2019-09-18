# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  agendaitem_id    :integer
#  result_id        :integer
#  photo_id         :integer
#  newsitem_id      :integer
#  commenttext      :text
#  commentable_id   :integer
#  commentable_type :string(255)
#

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
end
