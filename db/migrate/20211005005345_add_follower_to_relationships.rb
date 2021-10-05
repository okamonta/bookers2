class AddFollowerToRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :relationships, :follower, :integer
  end
end
