namespace :import do
  desc "Import our old agendaitems into the new database."
  task :agenda => :environment do
    class OldAgendaitem < ActiveRecord::Base
    end
    
    OldAgendaitem.find_each(:batch_size => 2000) do |old_agendaitem|
      Agendaitem.create(:name => old_agendaitem.Omschrijving, :date => old_agendaitem.Datum, :location => old_agendaitem.Plaats, :description => old_agendaitem.ExtraInfo,
                        :category => "Activiteit")
    end
  end
end
