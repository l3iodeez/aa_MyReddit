class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validate :has_content_or_url

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id
  )

  has_many(
    :postings,
    class_name: "PostSub",
    foreign_key: :post_id
    )

  has_many(
    :subs,
    through: :postings,
    source: :sub
  )

  has_many :comments



  def has_content_or_url
    errors.add(:base, "You must provide some content or a URL") unless url || content
  end

end
