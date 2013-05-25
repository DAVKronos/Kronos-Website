namespace :import do
  desc "Import our old users into the new database."
  task :users => :environment do
    class OldUser < ActiveRecord::Base; end
    
    OldUser.find_each(:batch_size => 2000) do |old_user|
      user = User.find_by_email(old_user.Email) 
      if(user)
        if(old_user.LidTypeID == 1)
          user.user_type_id = 1
        end
        if(old_user.LidTypeID == 2)
          user.user_type_id = 2
        end
        if(old_user.LidTypeID == 4)
          user.user_type_id = 3
        end
        if(old_user.LidTypeID == 5)
          user.user_type_id = 4
        end
        if(old_user.LidTypeID == 7)
          user.user_type_id = 6
        end
        if(old_user.LidTypeID == 6)
          user.user_type_id = 7
        end
        user.save
      end
    end
  end
end