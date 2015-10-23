class Sub < ActiveRecord::Base

  validates :title, :description, :moderator_id, presence: true

  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :moderator_id
  )

  has_many(
    :postings,
    class_name: "PostSub",
    foreign_key: :sub_id
  )

  has_many(
    :posts,
    through: :postings,
    source: :post
  )

end
