# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "faker"

10.times do |n|
    User.create!(
        email: Faker::Internet.unique.email,
        password: Faker::Internet.password(min_length: 8)
    )

    memo = Memo.create!(
        title: Faker::Lorem.sentence(word_count:10),
        content: Faker::Lorem.paragraphs(number: 5)
    )
    10.times do |m|
        Comment.create!(
            memo_id: memo.id,
            content:  Faker::Lorem.sentence(word_count:5)
        )            
    end
end
