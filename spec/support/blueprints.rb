require 'machinist/mongoid'

User.blueprint do
  email {"foo#{sn}@nulogy.com"}
  password {"password"}
end
