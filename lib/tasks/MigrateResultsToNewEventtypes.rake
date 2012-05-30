namespace :migrate do
  desc "Move results to new eventtype"
  task :results => :environment do
    Eventtype.find(:all, :conditions=> ["name ILIKE ?","%#{"weg"}%"]).each do |eventtype|
      destinationeventtype = Eventtype.find_by_name("Weg")
      puts "Wilt u dit #{eventtype.name} aanpassen?"
      answer = STDIN.gets
      if answer == "Ja"
        puts "Wat is de afstand van #{eventtype.name} ?"
        newDistance = STDIN.gets
        eventtype.events.each do |event|
          event.distance = newDistance
          event.eventtype_id = destinationeventtype.id
        end
        eventtype.destroy
      end
    end
  end
end