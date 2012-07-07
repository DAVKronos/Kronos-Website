namespace :migrate do
  desc "Move agendaitems category to new format"
  task :agendaitems => :environment do
    Agendaitem.find(:all, :conditions=> ["category ILIKE ?","%#{"Activiteit"}%"]).each do |agendaitem|
      destinationagendaitemtype = Agendaitemtype.find_by_name("Activiteit")
      agendaitem.agendaitemtype = destinationagendaitemtype
      agendaitem.save!
    end
    Agendaitem.find(:all, :conditions=> ["category ILIKE ?","%#{"wedstrijd(oude database)"}%"]).each do |agendaitem|
      destinationagendaitemtype = Agendaitemtype.find_by_name("Baanwedstrijd")
      agendaitem.agendaitemtype = destinationagendaitemtype
      agendaitem.save!
    end
    
  end
end
