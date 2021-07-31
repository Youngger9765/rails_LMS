# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User
puts("User seed is creating")
50.times do
	user = User.new(
		# name: Faker::Internet.user_name,
		email: Faker::Internet.email,
		password: "12345678"
	)
	user.save!
end

# School
puts("School seed is creating")
6.times do
	school = School.new(
		name: Faker::Team.name,
		description: Faker::Team.sport,
		is_public: [true, false].sample,
	)
	school.save!
end

# School staff
puts("School staff seed is creating")
School.all.each do |school|
	users = User.limit(5) 
	users.each do |user|
		school.school_staffs.create( 
			:name =>  Faker::Internet.user_name,
			:title => ["owner","teacher","school_admin"].sample,
			:user_id => user.id
		)
	end
end


