# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Wouter Timmermans"
  user.email                 "wtimmermans@example.com"
  user.address               "Geenstraat 3"
  user.city                  "Enschede"
  user.initials              "A.B.C."
  user.birthdate             "01-01-2000"
  user.login                 "protowouter"
  user.postalcode            "1234 AB"
  user.licensenumber         "123456"
  user.sex                   "Man"
  user.password              "foobar"
  user.password_confirmation "foobar"
end