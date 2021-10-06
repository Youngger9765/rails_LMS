# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User
puts("User seed is creating")
user = User.create(
  email: "ww@ww.com",
  password: "12345678"
)
50.times do
	user = User.create(
		# name: Faker::Internet.user_name,
		email: Faker::Internet.email,
		password: "12345678"
	)
end

# School
puts("School seed is creating")
5.times do
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
	users = User.order("RANDOM()").limit(5) 
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
	rand(1..3).times do
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

# Student
puts("Student seed is creating")
School.all.each do |school|
	users = User.order("RANDOM()").limit(rand(5..20)) 
	users.each do |user|
		school.students.create( 
			:name =>  Faker::Internet.user_name,
			:user_id => user.id,
			:city => Faker::Team.name,
			:age => 15,
			:grade => 8,
			:school_name => Faker::Team.name,
			:school_type => ["國小", "國中", "高中"].sample
		)
	end
end

# classroom / Teacher / Student ships
puts("classroom / Teacher / Student ships seed is creating")
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

	students = classroom.school.students.order("RAND()").limit(rand(5..10))
	students.each do |student|
		ClassroomStudentShip.create(
			student_id: student.id,
			classroom_id: classroom.id,
      status: ["applied","registered","removed"].sample
		)
	end

end

# Course
puts("Course/Teacher ships seed is creating")
School.all.each do |school|
	rand(5..10).times do
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

# Classroom / Course
puts("Classroom/Course seed is creating")
Classroom.all.each do |classroom|
	school = classroom.school
	select_courses = school.courses.order("RAND()").limit([3,4].sample)
	select_courses.all.each do |course|
		ClassroomCourseShip.create(
			:classroom_id => classroom.id,
			:course_id => course.id,
      :status => ['added','removed'].sample
		)
	end
end

# Sections/Content/Video,ppt
puts("Sections/Content seed is creating")
Course.all.each do |course|
	rand(1..3).times do
		position = course.sections.size + 1
		section = course.sections.create(
			name: Faker::Team.name,
			description: Faker::Team.sport,
			position: position
		)

		# Content maker
		puts("    Sections/Content Video seed is creating")
		videos_url_list = [
			"https://www.youtube.com/watch?v=U8stOjNfiM0",
			"https://www.youtube.com/watch?v=zKSD68Xnfhc",
			"https://www.youtube.com/watch?v=Jkqcx4kApUE",
			"https://www.youtube.com/watch?v=IyEdUFO3thg",
			"https://www.youtube.com/watch?v=MXRIX1PzBAg",
			"https://www.youtube.com/watch?v=8ts3I-Sf4Yc",
			"https://www.youtube.com/watch?v=vq6w1MmjBDo",
			"https://www.youtube.com/watch?v=sQWD5xAgkwM",
			"https://www.youtube.com/watch?v=hMNYiCmUhNc",
			"https://www.youtube.com/watch?v=NBrO7a3HKyk"
		]
		rand(1..3).times do
			video = Video.create(
				name: Faker::Team.name,
				url: videos_url_list.sample,
			)
			section.contents.create(
				:contentable => video
			)
		end

		puts("    Sections/Content Powerpoint seed is creating")
		ppt_url_list = [
			"https://docs.google.com/presentation/d/e/2PACX-1vTdP7L0vfEm5KgyLbK-PhA6hRipDvfoXf0UJOia9aLEtSzND9v8mfWj88l4MOxb91iGx3epTiQ-DTN5/embed",
			"https://docs.google.com/presentation/d/e/2PACX-1vTE_Oe6usoeVdmWHNNvcxjM9rR_MivQKzmoZUNW-7Zkc4L2uNvBkrahBVejzy1g3J0napSxHMof3PMk/embed"
		]
		rand(1..3).times do
			ppt = Powerpoint.create(
				name: Faker::Team.name,
				url: ppt_url_list.sample,
			)
			section.contents.create(
				:contentable => ppt
			)
		end

		puts("    Sections/Content Exercise seed is creating")
		cover_range_list = [
			"a1","a2","a3"
		]
		rand(1..3).times do
			ex = Exercise.create(
				name: Faker::Team.name,
				cover_range: cover_range_list.sample
			)
			section.contents.create(
				:contentable => ex
			)
		end
		
		position = 1
		section.contents.shuffle.each do |content|
			content.position = position
			content.save!
			position +=1
		end
	end
	
end

puts("Sections/Content Quiz seed is creating")
quiz_url_list = [
	"https://docs.google.com/presentation/d/113m_64qKKI5xw9cJkogEB-OiUpDOTRZIgVHfOGd31y4/preview?rm=minimal",
	"https://docs.google.com/presentation/d/1zHIAvxP6d4NfEct73nGDOzCOSSc0G5_w0ESaPDZzVI8/preview?rm=minimal"
]
cover_range_list = [
	"a1","a2","a3"
]
cover_range_list.each do |cover_range| 
	rand(5..10).times do
		quiz = Quiz.create(
			name: Faker::Team.name,
			text: Faker::Lorem.paragraph,
			text_url: quiz_url_list.sample,
			cover_range: cover_range,
			correct_answer: ["A","B","C","D"].sample
		)
	end
end
