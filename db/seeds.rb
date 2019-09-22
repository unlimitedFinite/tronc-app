# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
p 'seeding employees....'

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

p 'seeding initial report...'

Report.create(
  month: 9,
  year: 2019,
  gross_tips: 260,
  tax_due: 52,
  net_tips: 208
)

p 'seeding first tronc record...'

TroncRecord.create(
  week_end: Date.new(2019, 9, 7),
  report: Report.last,
  gross_tips: 260,
  tax_due: 52
)












