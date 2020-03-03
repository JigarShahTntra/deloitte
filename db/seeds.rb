roles = %w[ceo rmp partner director senior_manager manager assistant_manager senior associate junior admin]

roles.each do |role|
  Role.find_or_create_by(name: role)
end
puts 'roles created'

user = User.find_or_create_by(email: 'jigarshah2097@gmail.com') do |user|
  user.name = 'jigar shah'
  user.password = '123456'
  user.add_role :admin
  # user.confirmed_at = Time.now
end

puts "User #{user.email} created"