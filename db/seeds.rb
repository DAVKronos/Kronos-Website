# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
# pages
# text     "information"
# datetime "created_at"
# datetime "updated_at"
# string   "pagetag"
# integer  "user_id"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

usertype_proeflid = UserType.create({	:name => "Proeflid",
										:donor => false})

usertype_oudlid = UserType.create({		:name => "Oudlid",
										:donor => false})

user = User.create({:name => "Leon Schenk", 
                  :initials => "H.J.K.",
                  :email => "leon_schenk@kronos.nl", 
                  :birthdate => "01-01-2002",
                  :address => "Campuslaan 1",
                  :postalcode => "1337 MF",
                  :city => "Enschede",
                  :sex => "Man",
                  :licensenumber => "123456",
                  :password => "Foobar",
                  :password_confirmation => "Foobar"}, 
                  :as => :bestuur)

kegel = User.create({:name => "Kegel de Egel",
                    :initials => "K",
                    :email => "kegel@kronos.nl",
                    :birthdate => "01-01-2002",
                    :address => "Campuslaan 1",
                    :postalcode => "1337 MF",
                    :city => "Enschede",
                    :sex => "Man",
                    :licensenumber => "123456",
                    :password => "Foobar",
                    :password_confirmation => "Foobar"},
                   :as => :bestuur)
                  
                  
com = Commission.create({:name => "Bestuur",
                   :email => "bestuur@kronos.nl",
                   :description => "Het bestuur van Kronos"})
                   
CommissionMembership.create({:commission => com,
                             :user => user, 
                             :function => "Voorzitter"})
                             
eventtype = Eventtype.create({:name => "1500m", :formula => "( 1500 / $result ) * 3.6",
                  :measuringunit => "sec", :calculated_unit => "km/h"})
                  
agendaitemtype = Agendaitemtype.create({:name => "Baanwedstrijd", :is_match => true})

AgendaitemtypeEventtype.create({:eventtype => eventtype, :agendaitemtype => agendaitemtype})
