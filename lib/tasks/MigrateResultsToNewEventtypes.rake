namespace :migrate do
  desc "Move results to new eventtype"
  task :results => :environment do
    Eventtype.find(:all, :conditions=> ["name ILIKE ?","%#{"weg"}%"]).each do |eventtype|
      destinationeventtype = Eventtype.find_by_name("Weg")
      puts "Wat is de afstand van #{eventtype.name} ?"
      distance = STDIN.gets
      eventtype.events.each do |event|
        puts distance
      end
    end
  end
end
