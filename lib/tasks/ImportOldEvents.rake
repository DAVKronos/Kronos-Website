namespace :import do
  desc "Import our old users into the new database."
  task :evens => :environment do
    class OldEvent < ActiveRecord::Base; end
    
    OldEvent.find_each(:batch_size => 2000) do |old_event|
      
      event = Event.new()
      user.save
    end
  end
end
