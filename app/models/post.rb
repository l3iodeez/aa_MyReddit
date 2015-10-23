class Post < ActiveRecord::Base
  validates :title, :sub_id, :author_id, presence: true
  validate :has_content_or_url

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id
  )

  belongs_to :sub

  def has_content_or_url
    errors.add(:base, "You must provide some content or a URL") unless url || content
  end

end
