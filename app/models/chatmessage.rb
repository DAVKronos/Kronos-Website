class Chatmessage < ActiveRecord::Base
#  create_table "chatmessages", :force => true do |t|
#    t.string   "by"
#    t.text     "message"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.string   "email"
#    t.integer  "user_id"
#  end
  attr_accessible :by, :message, :email 
  belongs_to :user
  
  def allow_edit?(user)
    if user
      return (user.id == self.user_id)
    else
      return false
    end
  end
  
  def allow_destroy?(user)
    if user
      return (user.id == self.user_id)
    else
      return false
    end
  end
end
