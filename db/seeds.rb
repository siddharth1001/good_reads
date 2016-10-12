['registered', 'banned', 'moderator', 'admin'].each do |role|
  Role.find_or_create_by({name: role})
end

User.create!(
			 id: "1",
             email: "sid@sid.org",
             name: "Siddharth Rawat",
             role_id: "4",
             password:              "foobar",
             password_confirmation: "foobar"
             )

User.create!(
			 id: "2",
             email: "example@abc.org",
             name: "ExampleNAME",
             role_id: "4",
             password:              "foobar",
             password_confirmation: "foobar"
             )

Category.create!(id: "1",
	name: "Biography")

Category.create!(id: "2",
	name: "Fantasy")

Category.create!(id: "3",
	name: "Technology")

Book.create!(title: "Wings of Fire",
	description: " dummy description !",
	author: "A P J Abdul kalam",
	user_id: "1",
	category_id: "1",
       book_img: File.new("./app/assets/images/wings.jpeg"))

Book.create!(title: "I am Malala",
	description: " dummy description for I am Malala !",
	author: "Malala Yousafzai",
	user_id: "1",
	category_id: "1",
      book_img: File.new("./app/assets/images/ma.jpeg"))
Book.create!(title: "Computer Fundamentals",
	description: " description fpr computer fundamentals !",
	author: "Anita",
	user_id: "2",
	category_id: "3",
      book_img: File.new("./app/assets/images/com.jpeg"))
