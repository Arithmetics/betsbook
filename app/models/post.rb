class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy


  def liked_by?(user)
    if self.liking_users.all.any? { |e| e.id == user.id  }
      true
    else
      false
    end
  end

  def users_like(user)
    if self.liked_by?(user)
      self.likes.find_by("user_id": user.id)
    end
  end

end
