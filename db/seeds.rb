# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



5.times do |i|
  User.create!(username: "User#{i+1}", password: "password")

  3.times do |j|
    Sub.create!(title: "User#{i+1}, Title#{j+1}", description: "User#{i+1}, Desc#{j+1}",
    moderator_id: i+1)

    5.times do |k|
      post = Post.create!(title: "User#{i+1}, Title#{j+1}, Post #{k+1}", content: "blabla",
      author_id: (1..i+1).to_a.sample)

      post.sub_ids = [rand(j)+1]
      post.save!

    end
  end
end
