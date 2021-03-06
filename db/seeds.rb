#rails db:migrate:reset
#rails db:seed

['registered', 'banned', 'moderator', 'admin'].each do |role|
  Role.find_or_create_by({name: role})
end

User.create!(
             email: "sid@sid.org",
             name: "Siddharth Rawat",
             role_id: "4",
             password:              "foobar",
             password_confirmation: "foobar"
             )

User.create!(
             email: "example@abc.org",
             name: "ExampleNAME",
             role_id: "4",
             password:              "foobar",
             password_confirmation: "foobar"
             )

20.times do |n|
  name  = Faker::Name.name
  email = Faker::Internet.email
  password = "foobar"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

Category.create!(id: "1",
	name: "Biography")

Category.create!(id: "2",
	name: "Fantasy")

Category.create!(id: "3",
	name: "Technology")

users = User.order(:created_at).take(6)
some_images = ["harry_potter", "naruto.jpeg", "marvel.jpeg", "cat.jpeg"]

5.times do |n|
 #  	title = Faker::Book.title
 #      author = Faker::Book.author
 #  	description = Faker::Lorem.sentence(5)
 #  	image = Faker::Avatar.image 

  	users.each { |user| user.books.create!(
  	title: Faker::Book.title,
  	description: Faker::Lorem.paragraph,
  	author: Faker::Book.author,
  	category_id: "#{(n%3) + 1}",
  	book_img: File.open(Dir.glob(File.join(Rails.root, './public/book_images', '*')).sample)
  	)}
end

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
