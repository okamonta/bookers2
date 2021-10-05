class RemoveFollowedIdFromRelationships < ActiveRecord::Migration[5.2]
  def change
    remove_column :relationships, :FollowedId, :integer
  end
end
