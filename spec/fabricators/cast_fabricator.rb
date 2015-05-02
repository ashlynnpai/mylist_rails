Fabricator(:cast) do
  title { Faker::Lorem.paragraph(2) }
  episode { Faker::Number.digit }
  watched false
  favorite false
end