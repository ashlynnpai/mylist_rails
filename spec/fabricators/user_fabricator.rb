Fabricator(:user) do
  email { Faker::Internet.email }
  password "password"
  password_confirmation "password"
  name { Faker::Name.name }
  admin false
  public_profile true
end