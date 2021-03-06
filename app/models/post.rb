class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  mount_uploader :picture, PictureUploader
  validate :picture_size
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, length: { maximum: 280 }


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

  private ###################################

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

end
