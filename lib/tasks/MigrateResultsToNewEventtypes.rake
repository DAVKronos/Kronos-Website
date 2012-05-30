namespace :migrate do
  desc "Move results to new eventtype"
  task :results => :environment do
    class OldUser < ActiveRecord::Base; end
    Eventtype.find(:all, :conditions=> ["name ILIKE ?","%#{"1"}%"]).each do |eventtype|
      puts eventtype.name
    end
  end
end
