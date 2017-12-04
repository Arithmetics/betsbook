class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :sent_friend_requests, foreign_key: "requestor_id", class_name: "FriendRequest", dependent: :destroy
  has_many :recieved_friend_requests, foreign_key: "requestee_id", class_name: "FriendRequest", dependent: :destroy

  has_many :initiated_friendships, through: :sent_friend_requests, source: :requestee
  has_many :proposed_friendships, through: :recieved_friend_requests, source: :requestor

  #think i can take this out
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  after_create :welcome_send
  after_update :crop_avatar


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

 def password_required?
   super && provider.blank?
 end

 def update_with_password(params, *options)
  if encrypted_password.blank?
    update_attributes(params, *options)
  else
    super
  end
 end


  def welcome_send
    WelcomeMailer.welcome_send(self).deliver
  end

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  def friends
    x = self.sent_friend_requests.all.where(accepted:true).map{ |x| x.requestee }
    y = self.recieved_friend_requests.all.where(accepted:true).map{ |x| x.requestor }
    x + y
  end

  def pending_friends
    x = self.sent_friend_requests.all.where(accepted:false).map{ |x| x.requestee }
    y = self.recieved_friend_requests.all.where(accepted:false).map{ |x| x.requestor }
    x + y
  end

  def pending_requests
    self.recieved_friend_requests.where(accepted:false)
  end

  def is_friends?(user)
    self.friends.any? { |e| e == user  }
  end

  def friend_requested?(user)
    self.pending_friends.any? { |e| e == user  }
  end

  def all_friend_requests
    x = self.sent_friend_requests.all
    y = self.recieved_friend_requests.all
    x + y
  end

  def find_associated_friend_request(friend)
    x = self.recieved_friend_requests.all.where(requestor: friend)
    if x.empty?
      x = self.sent_friend_requests.all.where(requestee: friend)
    end
    x
  end

  def posts_feed
    friends_ids = self.friends.map{|x| x.id}
    friends_ids.push(self.id).join(',')
    Post.where(user_id: friends_ids)
  end

end
