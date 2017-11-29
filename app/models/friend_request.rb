class FriendRequest < ApplicationRecord
  belongs_to :requestor, class_name: "User"
  belongs_to :requestee, class_name: "User"
  validates :requestor, uniqueness: {scope: :requestee}





  def accept
    if self.accepted == false
      update_attribute(:accepted, true)
    end
  end




end
