# By using the symbol ':user', we get Factory Girl to simulate the User model.

FactoryBot.define do
	factory :user do
	  name                  {"Wouter Timmermans"}
	  email                 {"wouter@example.com"}
	  address               {"Geenstraat 3"}
	  city                  {"Enschede"}
	  initials              {"A.B.C."}
	  birthdate             {"01-01-2000"}
	  postalcode            {"1234 AB"}
	  licensenumber         {"123456"}
	  sex                   {"Man"}
	  password              {"foobar"}
	  password_confirmation {"foobar"}
		
		factory :admin do
			email	{"woutertimmermans@kronos.nl"}
			after(:create) do |admin|
				commission = FactoryBot.create(:bestuur)
				FactoryBot.create(:commission_membership, user: admin, commission: commission)
			end
		end
	end
	
	factory :commission_membership do
		function {"Voorzitter"}
		user
		commission
	end
	
	factory :bestuur, class: Commission do
		name					{"Bestuur"}
		description { "}Het bestuur van Kronos"}
		email 				{"bestuur@kronos.nl"}
	end
		
	factory :commission do
	  name           {"Test"}
	  description    {"Test Commission"}
	  email          {"test@kronos.nl"}
	end
end


