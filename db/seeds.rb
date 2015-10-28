# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.new
u.email = "xuite.joke@gmail.com"
u.password = "12345678"
u.password_confirmation = "12345678"
u.is_admin = true
u.save


event = Event.new
event.name = "Rails 即戰力班 2016"
event.seat_quantity = "20"
event.started_at = Date.today
event.end_at = Date.today + 7.days
event.save


tt1 = event.ticket_types.build
tt1.name = "早鳥票"
tt1.price = "20000"
tt1.amount = 10
tt1.save


tt2 = event.ticket_types.build
tt2.name = "一般票"
tt2.price = "25000"
tt1.amount = 10
tt2.save