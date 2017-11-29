class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :comments
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post

  has_many :sent_friend_requests, foreign_key: "requestor_id", class_name: "FriendRequest"
  has_many :recieved_friend_requests, foreign_key: "requestee_id", class_name: "FriendRequest"

  has_many :initiated_friendships, through: :sent_friend_requests, source: :requestee
  has_many :proposed_friendships, through: :recieved_friend_requests, source: :requestor


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
