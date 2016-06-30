# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# ///// ADMIN

z = User.new 
z.first_name = "Nash"
z.last_name = "Mahupete"
z.email ="NMahupete@qliomaha.com "
z.password = "nashty"
z.is_a_coach = false
z.is_an_admin = true
z.save

# ///// COACHES

x = User.new 
x.first_name = "Alex"
x.last_name = "Coachly"
x.email ="coach1@gmail.com"
x.password = "password"
x.is_a_coach = true
x.is_an_admin = false
x.save

y = User.new
y.first_name = "Bethany"
y.last_name = "Coachworth"
y.email = "coach2@gmail.com"
y.password = "password"
y.is_a_coach = true
y.is_an_admin = false
y.save

# ///// CLIENTS

a = User.new 
a.first_name = "Amanda"
a.last_name = "Clientson"
a.email ="client1@gmail.com"
a.password = "password"
a.is_a_coach = false
a.is_an_admin = false
a.save

b = User.new 
b.first_name = "Bruce"
b.last_name = "Clienthouse"
b.email ="client2@gmail.com"
b.password = "password"
b.is_a_coach = false
b.is_an_admin = false
b.save

c = User.new 
c.first_name = "Cora"
c.last_name = "Clientforth"
c.email ="client3@gmail.com"
c.password = "password"
c.is_a_coach = false
c.is_an_admin = false
c.save

# ////// MENTORSHIPS

m1 = Mentorship.new
m1.client = a.id
m1.coach = x.id
m1.save

m2 = Mentorship.new
m2.client = b.id
m2.coach = x.id
m2.save

m3 = Mentorship.new
m3.client = c.id
m3.coach = y.id
m3.save

# /////// MESSAGES

w1 = Message.new
w1.to = a.id
w1.from = x.id
w1.content = "Hey, client 1- This is coach 1."
w1.save

w2 = Message.new
w2.to = x.id
w2.from = a.id
w2.content = "Hey, coach 1- This is client 1."
w2.save

w3 = Message.new
w3.to = b.id
w3.from = x.id
w3.content = "Hey, client 2- This is coach 1."
w3.save

w4 = Message.new
w4.to = x.id
w4.from = b.id
w4.content = "Hey, coach 1- This is client 2."
w4.save

w5 = Message.new
w5.to = c.id
w5.from = y.id
w5.content = "Hey, client 3- This is coach 2."
w5.save

w6 = Message.new
w6.to = y.id
w6.from = c.id
w6.content = "Hey, coach 2- This is client 3."
w6.save

# ////// PLANS

p1 = Plan.new
p1.client = a.id
p1.title = "Client 1's #1 PLAN"
p1.content = "These are the details of your #1 plan, Client 1."
p1.save

p2 = Plan.new
p2.client = a.id
p2.title = "Client 1's #2 PLAN"
p2.content = "These are the details of your #2 plan, Client 1."
p2.save

p3 = Plan.new
p3.client = b.id
p3.title = "Client 2's only PLAN"
p3.content = "These are the details of your only plan, Client 2."
p3.save

p4 = Plan.new
p4.client = c.id
p4.title = "Client 3's #1 PLAN"
p4.content = "These are the details of your #1 plan, Client 3."
p4.save

p5 = Plan.new
p5.client = c.id
p5.title = "Client 3's #2 PLAN"
p5.content = "These are the details of your #2 plan, Client 3."
p5.save

# ////////

am1 = AdminMessage.new
am1.from_name = "Lindsey Lohan"
am1.from_email = "real_ll@gmail.com"
am1.content = "My friends tell me I need some guidance. Help?"
am1.save

am2 = AdminMessage.new
am2.from_name = "Ghost of Steve Jobs"
am2.from_email = "@gmail.com"
am2.content = "Do you work with folks on the other side?"
am2.save

am3 = AdminMessage.new
am3.from_name = "David Cameron"
am3.from_email = "wavy_davey@gmail.com"
am3.content = "So, this whole Brexit thing has got me considering my options. Where to now? Email me when you can! Thx."
am3.save



# /////////