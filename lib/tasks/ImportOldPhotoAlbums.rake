namespace :import do
  desc "Import our old users into the new database."
  task :photoalbums => :environment do
    class OldPhotoalbum < ActiveRecord::Base; end
    
    OldPhotoalbum.find_each(:batch_size => 2000) do |old_album|
      
      album = Photoalbum.new(:name => old_album.Naam)
      album.save
    end
  end
end