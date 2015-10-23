class User < ActiveRecord::Base

  after_initialize :ensure_session_token
  validates :password, length: { minimum: 6, allow_nil: true}


  has_many(
    :posts,
    class_name: "Post",
    foreign_key: :author_id,
    dependent: :destroy
  )

  has_many(
    :moderated_subs,
    class_name: "Sub",
    foreign_key: :moderator_id,
    dependent: :destroy
  )

  has_many(
    :comments,
    class_name: "Comment",
    foreign_key: :author_id
  )


  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    return nil unless user
    return user if user.is_password?(password)
    nil
  end


  def password
    @password
  end

  def password=(new_password)
    @password = new_password
    self.password_digest = BCrypt::Password.create(new_password)
  end

  def is_password?(input_password)
    BCrypt::Password.new(self.password_digest).is_password?(input_password)
  end

  def generate_session_token
    token = SecureRandom::urlsafe_base64(16)
    while User.exists?(session_token: token)
      token = SecureRandom::urlsafe_base64(16)
    end
    token
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
  end

end
