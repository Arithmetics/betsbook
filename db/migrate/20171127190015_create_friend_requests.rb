class CreateFriendRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_requests do |t|
      t.boolean :accepted
      t.references :requestor
      t.references :requestee

      t.timestamps
    end
  end
end
