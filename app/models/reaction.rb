class Reaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :newsitem
  belongs_to :photo
  belongs_to :agendaitem
  belongs_to :result
end
