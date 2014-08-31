harry   = User.create!(name: "Harry",   email: "harry@harry.com")
joe   = User.create!(name: "Joe",   email: "joe@joe.com")
tim = User.create!(name: "Tim", email: "tim@tim.com")

ruby_on_rails       = Subject.create!(name: "Ruby on Rails")
lean_start_ups      = Subject.create!(name: "Lean Startups")
wing_chun           = Subject.create!(name: "Wing Chun")
project_management  = Subject.create!(name: "Project Management")
tai_chi             = Subject.create!(name: "Tai Chi")


# ASKING TO BE TUTORED:
# Tim asks Harry to tutor him in RoR
harry.pending_invites_to_be_a_tutor.create!(student: tim, subject: ruby_on_rails, message: "Harry, can you help me out with RoR?")

# Harry asks Joe to tutor him in Wing Chun
joe.pending_invites_to_be_a_tutor.create!(student: harry, subject: wing_chun, message: "Joe, can you teach me some Wing Chun?")

# Joe asks Tim to tutor him in Project Managament
tim.pending_invites_to_be_a_tutor.create!(student: joe, subject: project_management, message: "Tim, how does KanBan work?")


# ACCEPTING & REJECTING TUTOR REQUESTS:
# Harry accepts Tim's invite
harry.pending_invites_to_be_a_tutor.first.update(accepted: true)

# Joe rejects Harry's invite
joe.pending_invites_to_be_a_tutor.first.update(accepted: false)


# ASKING TO BE A STUDENT:
# Tim asks Joe if he can tutor him in RoR
joe.pending_invites_to_be_a_student.create!(tutor: tim, subject: ruby_on_rails, message: "Joe, do you want to learn some RoR from me?")

# Harry asks Tim if he can tutor him in Lean Startup
tim.pending_invites_to_be_a_student.create!(tutor: harry, subject: lean_start_ups, message: "Tim, are you interested in Lean Startups?")

# Joe asks Harry if he can tutor him in Tai Chi
harry.pending_invites_to_be_a_student.create!(tutor: joe, subject: tai_chi, message: "Harry, can I teach you Tai Chi?") 


# ACCEPTING & REJECTING STUDENT REQUESTS:
# Joe rejects Tim's invite
joe.pending_invites_to_be_a_student.first.update(accepted: false)

# Tim accepts Harry's invite
tim.pending_invites_to_be_a_student.first.update(accepted: true)


# CLI output to verify
[harry, joe, tim].each do |user|
  user.reload
  puts "\n\n"
  puts "TUTORING:"
  puts "#{user.name} has the following pending invites to be a tutor: #{user.pending_invites_to_be_a_tutor.map { |i| "from #{i.student.name}: #{i.message}" }}"
  puts "#{user.name} has rejected the following invites to be a tutor: #{user.rejected_invites_to_be_a_tutor.map { |i| "from #{i.student.name}: #{i.message}" }}"
  puts "#{user.name} is tutoring the following students: #{user.tutorships_as_tutor.map { |t| "#{t.student.name} - #{t.subject.name}" }}"
  puts "\n"
  puts "STUDYING:"
  puts "#{user.name} has the following pending invites to be a student: #{user.pending_invites_to_be_a_student.map { |i| "from #{i.tutor.name}: #{i.message}" }}"
  puts "#{user.name} has rejected the following invites to be a student: #{user.rejected_invites_to_be_a_student.map { |i| "from #{i.tutor.name}: #{i.message}" }}"
  puts "#{user.name} is studying under the following tutors: #{user.tutorships_as_student.map { |t| "#{t.tutor.name} - #{t.subject.name}" }}"
end