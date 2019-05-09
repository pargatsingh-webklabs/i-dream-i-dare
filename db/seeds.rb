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
z.email ="nmahupete@qliomaha.com "
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

d = User.new 
d.first_name = "Martin"
d.last_name = "Client-Scorsese"
d.email ="client4@gmail.com"
d.password = "password"
d.is_a_coach = false
d.is_an_admin = false
d.save

e = User.new 
e.first_name = "Bernie"
e.last_name = "Clientbern"
e.email ="client5@gmail.com"
e.password = "password"
e.is_a_coach = false
e.is_an_admin = false
e.save

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

m4 = Mentorship.new
m4.client = d.id
m4.coach = y.id
m4.save

m5 = Mentorship.new
m5.client = e.id
m5.coach = y.id
m5.save

# /////// MESSAGES

w1 = Message.new
w1.to = a.id
w1.from = x.id
w1.content = "Hey, did you get a chance to look at the goals for next week?"
w1.save

w2 = Message.new
w2.to = x.id
w2.from = a.id
w2.content = "Yes- That all looks good to me!"
w2.save

w1b = Message.new
w1b.to = a.id
w1b.from = x.id
w1b.content = "Please let me know how things go on Wednesday! Keep in touch. :)"
w1b.save

w2b = Message.new
w2b.to = x.id
w2b.from = a.id
w2b.content = "You've got it! Thanks for the support."
w2b.save

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

# ///// GROUPS

g1 = Group.new
g1.name = "Folks Who Like Stuff"
g1.description = "If you like stuff, this group is for you."
g1.creator = a.id
g1.privacy = "public"
g1.save

g2 = Group.new
g2.name = "Bears who wear Hats"
g2.description = "What are they trying to prove?"
g2.creator = c.id
g2.privacy = "public"
g2.save

g3 = Group.new
g3.name = "What About Boats and Manta Rays?"
g3.description = "Water, and things that are in the water. Discuss!"
g3.creator = c.id
g3.privacy = "private"
g3.save

# ///// GROUP MEMBERSHIPS

gb1 = GroupMembership.new
gb1.user_id = x.id
gb1.group_id = g1.id
gb1.invited_by = c.id
gb1.save 

gb1 = GroupMembership.new
gb1.user_id = c.id
gb1.group_id = g1.id
gb1.invited_by = c.id
gb1.save 

gb2 = GroupMembership.new
gb2.user_id = b.id
gb2.group_id = g2.id
gb2.invited_by = b.id
gb2.save 

gb3 = GroupMembership.new
gb3.user_id = a.id
gb3.group_id = g3.id
gb3.invited_by = a.id
gb3.save 

gb4 = GroupMembership.new
gb4.user_id = a.id
gb4.group_id = g1.id
gb4.invited_by = c.id
gb4.save 

gb5 = GroupMembership.new
gb5.user_id = a.id
gb5.group_id = g2.id
gb5.invited_by = b.id
gb5.save 

gb6 = GroupMembership.new
gb6.user_id = b.id
gb6.group_id = g3.id
gb6.invited_by = a.id
gb6.save 

gb7 = GroupMembership.new
gb7.user_id = y.id
gb7.group_id = g1.id
gb7.invited_by = c.id
gb7.save 

# ///// GROUP MESSAGES

gm1 = GroupMessage.new
gm1.from = a.id
gm1.group_id = g1.id
gm1.content = "I like stuff that's round."
gm1.save

gm2 = GroupMessage.new
gm2.from = c.id
gm2.group_id = g1.id
gm2.content = "Faulkner is a bit annoying, no?"
gm2.save

gm3 = GroupMessage.new
gm3.from = a.id
gm3.group_id = g3.id
gm3.content = "This private group is VERY exclusive."
gm3.save

gm4 = GroupMessage.new
gm4.from = c.id
gm4.group_id = g3.id
gm4.content = "Yeah, it kinda is!"
gm4.save

# ///////// NOTIFICATION PREFERENCES

np = NotificationPreference.new
np.notification_reason = 'plan created'
np.notification_type = 'sms'
np.user_id = a.id
np.save

np2 = NotificationPreference.new
np2.notification_reason = 'message received'
np2.notification_type = 'sms'
np2.user_id = b.id
np2.save

np3 = NotificationPreference.new
np3.notification_reason = 'group message received'
np3.notification_type = 'sms'
np3.user_id = c.id
np3.save

