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
10.times do
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
	users = User.order("RAND()").limit(5) 
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
	users = User.order("RAND()").limit(rand(5..20)) 
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
			classroom_id: classroom.id
		)
	end

end

# Course
puts("Course/Teacher ships seed is creating")
School.all.each do |school|
	rand(1..3).times do
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
	select_courses = school.courses.order("RAND()").limit([1,4].sample)
	select_courses.all.each do |course|
		ClassroomCourseShip.create(
			:classroom_id => classroom.id,
			:course_id => course.id
		)
	end
end

# Sections/Content/Video,ppt
puts("Sections/Content seed is creating")
Course.all.each do |course|
	rand(1..3).times do
		position_id = course.sections.size + 1
		section = course.sections.create(
			name: Faker::Team.name,
			description: Faker::Team.sport,
			position_id: position_id
		)

		# Content maker
		videos_url_list = [
			"https://www.youtube.com/watch?v=U8stOjNfiM0&list=PLrTCIgdLHnAovfmFEC6q1snSOldbIygRK&index=1&ab_channel=%E6%A8%8A%E7%99%BB%E8%AF%BB%E4%B9%A6",
			"https://www.youtube.com/watch?v=zKSD68Xnfhc&list=PLrTCIgdLHnAovfmFEC6q1snSOldbIygRK&index=2",
			"https://www.youtube.com/watch?v=Jkqcx4kApUE&list=PLrTCIgdLHnAovfmFEC6q1snSOldbIygRK&index=3&ab_channel=%E6%A8%8A%E7%99%BB%E8%AF%BB%E4%B9%A6",
			"https://www.youtube.com/watch?v=IyEdUFO3thg&list=PLrTCIgdLHnAovfmFEC6q1snSOldbIygRK&index=4&ab_channel=%E6%A8%8A%E7%99%BB%E8%AF%BB%E4%B9%A6",
			"https://www.youtube.com/watch?v=MXRIX1PzBAg&list=PLrTCIgdLHnAovfmFEC6q1snSOldbIygRK&index=5",
			"https://www.youtube.com/watch?v=8ts3I-Sf4Yc&list=PLrTCIgdLHnAovfmFEC6q1snSOldbIygRK&index=6",
			"https://www.youtube.com/watch?v=vq6w1MmjBDo&list=PLrTCIgdLHnAovfmFEC6q1snSOldbIygRK&index=7&ab_channel=%E6%A8%8A%E7%99%BB%E8%AF%BB%E4%B9%A6",
			"https://www.youtube.com/watch?v=sQWD5xAgkwM&list=PLrTCIgdLHnAovfmFEC6q1snSOldbIygRK&index=8&ab_channel=%E6%A8%8A%E7%99%BB%E8%AF%BB%E4%B9%A6",
			"https://www.youtube.com/watch?v=hMNYiCmUhNc&list=PLrTCIgdLHnAovfmFEC6q1snSOldbIygRK&index=9&ab_channel=%E6%A8%8A%E7%99%BB%E8%AF%BB%E4%B9%A6",
			"https://www.youtube.com/watch?v=NBrO7a3HKyk&list=PLrTCIgdLHnAovfmFEC6q1snSOldbIygRK&index=10&ab_channel=%E6%A8%8A%E7%99%BB%E8%AF%BB%E4%B9%A6"
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
		rand(1..3).times do
			ppt = Powerpoint.create(
				name: Faker::Team.name,
				url: Faker::Internet.url,
			)
			section.contents.create(
				:contentable => ppt
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
