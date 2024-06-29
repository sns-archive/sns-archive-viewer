# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do |n|
    p "========== user create #{n+1}=========="
    User.create!(
        email: "example_#{n+1}@example.com",
        password: "password"
    )

    p "========== memo create #{n+1}=========="
    Memo.create!(
        title: "title_#{n+1}",
        content: "content_#{n+1}"
    )

    p "========== comment create #{n+1}=========="
    Comment.create!(
        memo_id: n+1,
        content: "content_#{n+1}"
    )
end
