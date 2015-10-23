class Comment < ActiveRecord::Base
  belongs_to :post

  belongs_to(
    :parent_comment,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  )

  has_many(
    :children,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  )
end
