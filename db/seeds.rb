# coding: utf-8

User.create!(name: "鈴木郁哉",
             tel: "08099998888",
             school: "水海道一高",
             grade: 3,
             number: 23839,
             password: "password",
             password_confirmation: "password",
             admin: true)

8.times do |n|
  name  = Faker::Name.name
  tel = "0901111222#{n+1}"
  password = "password"
  school = "茨城#{n+1}中学校"
  grade = 1
  number = "1111#{n}"
  User.create!(name: name,
               tel: tel,
               school: school,
               grade: grade,
               number: number,
               password: password,
               password_confirmation: password)
end