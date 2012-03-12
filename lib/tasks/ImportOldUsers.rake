namespace :import do
  desc "Import our old users into the new database."
  task :users => :environment do
    class OldUser < ActiveRecord::Base; end
    
    OldUser.find_each(:batch_size => 2000) do |old_user|
      password = Authlogic::Random.friendly_token
      original = old_user.Voornaam + old_user.Achternaam
      cleaned = ""
      original.each_byte { |x|  cleaned << x unless x > 127   }
      
      user = User.new({:name => old_user.Voornaam + " " + old_user.Achternaam, :initials => old_user.Voorletters, :email => old_user.Email,
                   :birthdate => old_user.GeboorteDatum, :postalcode => old_user.Postcode, :city => old_user.Woonplaats,
                   :sex => old_user.Geslacht == 1 ? "Man" : "Vrouw", :address => old_user.Adres, :login => cleaned ,
                   :password => password, :password_confirmation => password, :licensenumber => old_user.LicentieNummer }, :as => :bestuur)
      user.save
    end
  end
end