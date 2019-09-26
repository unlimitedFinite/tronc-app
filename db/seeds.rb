# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
p 'creating user'

u = User.create(
  email: 'test@test.com',
  password: 'secret'
)

p 'seeding employees....'

Employee.create(
  name: 'Abdul',
  active: true,
  user: u
)
Employee.create(
  name: 'Bernard',
  active: true,
  user: u
)
Employee.create(
  name: 'Ana Chiara',
  active: true,
  user: u
)
Employee.create(
  name: 'Bez',
  active: true,
  user: u
)
Employee.create(
  name: 'Luis',
  active: true,
  user: u
)

p 'seeding initial report...'

Report.create(
  report_start: Date.new(2019, 9, 6),
  gross_tips: 260,
  tax_due: 52,
  net_tips: 208,
  user: User.last
)

p 'seeding first tronc record...'

TroncRecord.create(
  week_end: Date.new(2019, 9, 7),
  report: Report.last,
  gross_tips: 260,
  tax_due: 52,
  user: User.last
)












