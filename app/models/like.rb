class Like < ApplicationRecord
  validates :user, uniqueness: {scope: :post}
  belongs_to :post
  belongs_to :user





end
