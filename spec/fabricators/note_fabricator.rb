Fabricator(:note) do
  content { Faker::Lorem.paragraph(3) }
end