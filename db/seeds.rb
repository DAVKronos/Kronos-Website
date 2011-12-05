# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.create(:name => "Kegel Kronos", 
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
                  :password_confirmation => "Foobar")