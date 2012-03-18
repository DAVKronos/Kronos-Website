namespace :import do
  desc "Import our old users into the new database."
  task :events => :environment do
    class OldEvent < ActiveRecord::Base
      has_many :results, :class_name => 'OldResult', :foreign_key => 'WedstrijdID'
    end
    class OldResult < ActiveRecord::Base
      belongs_to :event, :class_name => 'OldEvent'
    end
    
    OldEvent.find_each(:batch_size => 2000) do |old_event|
      
      agendaitem = Agendaitem.new(:date => old_event.Datum, :location => old_event.Plaats, :name => old_event.Naam, :category => "wedstrijd(oude database)")
      agendaitem.reactions.build(:reactiontext => old_event.Opmerking) unless old_event.Opmerking.empty?
      old_event.results.find_each do |old_result|
        eventtype = Eventtype.find_or_create_by_name(old_result.Onderdeel)
        event = Event.find_or_create_by_eventtype_id_and_agendaitem_id(eventtype.id, agendaitem.id)
        event.results.build(:result => old_result.Prestatie, :username => old_result.Deelnemer)
        event.date = Time.now
        agendaitem.events << event
      end
      agendaitem.save
    end
  end
end
