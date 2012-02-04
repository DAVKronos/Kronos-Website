# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.create({:name => "Kegel Kronos", 
                  :initials => "H.J.K.",
                  :email => "kegel@kronos.nl", 
                  :birthdate => "01-01-2002",
                  :address => "Campuslaan 1",
                  :postalcode => "1337 MF",
                  :city => "Enschede",
                  :sex => "Man",
                  :licensenumber => "123456",
                  :login => "Henk",
                  :password => "Foobar",
                  :password_confirmation => "Foobar"}, 
                  :as => :bestuur)
User.first.has_role!(:admin)

User.create({:name => "Wouter Timmermans", 
                  :initials => "W.J.M.",
                  :email => "wijdoennietopen@dedeur.nl", 
                  :birthdate => "01-01-2002",
                  :address => "Campuslaan 1",
                  :postalcode => "1337 MF",
                  :city => "Enschede",
                  :sex => "Man",
                  :licensenumber => "123456",
                  :login => "wouter",
                  :password => "Henk",
                  :password_confirmation => "Henk"},
                  :as => :bestuur)
                
# pages
# text     "information"
# datetime "created_at"
# datetime "updated_at"
# string   "pagetag"
# integer  "user_id"

Page.create({:information => "Hier staat informatie",
              :pagetag => "informatie",
              :user_id => User.first.id})

Page.create({:information => "Hier staat informatie",
              :pagetag => "kronos",
              :user_id => User.first.id})

Page.create({:information => "Hier staat informatie",
              :pagetag => "contact",
              :user_id => User.first.id})
          
Page.create({:information => "Hier staat informatie",
              :pagetag => "atletiek",
              :user_id => User.first.id})
         
Page.create({:information => "Hier staat informatie",
              :pagetag => "about",
              :user_id => User.first.id})