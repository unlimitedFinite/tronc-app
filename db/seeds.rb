# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Employee.create(
  name: 'Abdul',
  active: true
)
Employee.create(
  name: 'Bernard',
  active: true
)
Employee.create(
  name: 'Ana Chiara',
  active: true
)
Employee.create(
  name: 'Bez',
  active: true
)
Employee.create(
  name: 'Luis',
  active: true
)

m = 1
12.times do
  Report.create(
    month: m,
    year: 2019
  )
  m += 1
end

m = 1
12.times do
  Report.create(
    month: m,
    year: 2020
  )
  m += 1
end
