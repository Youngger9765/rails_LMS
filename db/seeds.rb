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
		school.staffs.create( 
			:name =>  Faker::Internet.user_name,
			:title => ["owner","teacher","school_admin"].sample,
			:user_id => user.id
		)
	end
end

# Classroom
puts("Classroom seed is creating")
School.all.each do |school|
	rand(8).times do
		school.classrooms.create(
			name: Faker::Team.name,
			description: Faker::Team.sport,
			is_public: [true, false].sample,
			city: ["台北","新北","高雄"].sample,
			school_name: school.name,
			school_type: ["國小","國中","高中"].sample,
			grade: (1..12).to_a.sample,
		)
	end
end

# Teacher / classroom ships
puts("Teacher/classroom ships seed is creating")
Classroom.all.each do |classroom|
	staffs = classroom.school.staffs.limit(2)
	staffs.each do |staff|
		teacher = Teacher.new(
			:name => staff.name,
			:user_id => staff.user_id			
		)
		teacher.save!

		ClassroomTeacherShip.create(
			teacher_id: teacher.id,
			classroom_id: classroom.id
		)
	end
end

# Course
puts("Course/Teacher ships seed is creating")
School.all.each do |school|
	rand(5).times do
		course = school.courses.create(
			name: Faker::Team.name,
			description: Faker::Team.sport,
			goal: Faker::Lorem.paragraph,
      		note: Faker::Lorem.paragraph,
      		tool: Faker::Lorem.paragraph
		)

		staffs = school.staffs.limit([1,2].sample)
		staffs.each do |staff|
			teacher = Teacher.find_by(:user_id => staff.user_id)
			if teacher.nil?
				teacher = Teacher.new(
					:name => staff.name,
					:user_id => staff.user_id			
				)
				teacher.save!
			end

			CourseTeacherShip.create(
				teacher_id: teacher.id,
				course_id: course.id
			)
		end

	end
end

# Sections
puts("Sections seed is creating")
Course.all.each do |course|
	rand(5).times do
		position_id = course.sections.size + 1
		section = course.sections.create(
			name: Faker::Team.name,
			description: Faker::Team.sport,
			position_id: position_id
		)
	end
end
