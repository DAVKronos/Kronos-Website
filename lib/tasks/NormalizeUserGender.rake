namespace :migrate do
  desc "Normalize the gender field of a user"
  task normalize_user_gender: :environment do
    User.all.each do |user|
      case user.sex
           when 'M', 'Male', 'Man'
                user.sex = 'Male'
           when 'F', 'Female', 'Vrouw'
                user.sex = 'Female'
      end
      user.save
    end
  end

end
