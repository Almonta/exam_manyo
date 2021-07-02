# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |n|
  name = "サンプル#{n + 1}"
  email = "sample#{n + 1}@sample.com"
  password = "password#{n + 1}"
  User.create!(name: name,
              email: email,
              password_digest: password,
              )
end

# 20.times do |n|
#   task_name = "タスク#{n + 1}"
#   details = "詳細#{n + 1}"
#   deadline = "期日#{n + 1}"
#   User.create!(name: name,
#               email: email,
#               password_digest: password,
#               )
# end

# 20.times do |n|
#   name = "サンプル#{n + 1}"
#   email = "sample#{n + 1}@sample.com"
#   password = "password#{n + 1}"
#   User.create!(name: name,
#               email: email,
#               password_digest: password,
#               )
# end