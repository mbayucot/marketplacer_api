# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(
  email: 'dummy@example.com',
  password: 'password',
  password_confirmation: 'password'
)

Promotion.create!([
  { threshold: 100, discount: 0.20 },
  { threshold: 50, discount: 0.15 },
  { threshold: 20, discount: 0.10 }
])