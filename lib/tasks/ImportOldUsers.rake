namespace :import do
  desc "Import our old users into the new database."
  task :users => :environment do
    class OldUser < ActiveRecord::Base; end
    
    OldUser.find_each(:batch_size => 2000) do |old_user|
      password_length = 6
      password = Devise.friendly_token.first(password_length)
      if !old_user.MobieleTelefoon.empty?
        telefoon = old_user.MobieleTelefoon
      else
        telefoon = old_user.Telefoon
      end
      
      user = User.new({:name => old_user.Voornaam + " " + old_user.Achternaam, :initials => old_user.Voorletters, :email => old_user.Email,
                   :birthdate => old_user.GeboorteDatum, :postalcode => old_user.Postcode, :city => old_user.Woonplaats,
                   :sex => old_user.Geslacht == 1 ? "Man" : "Vrouw", :address => old_user.Adres,
                   :password => password, :password_confirmation => password, :licensenumber => old_user.LicentieNummer, :phonenumber => telefoon }, :as => :bestuur)
      user.save
    end
  end
end