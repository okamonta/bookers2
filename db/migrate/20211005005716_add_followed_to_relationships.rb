class AddFollowedToRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :relationships, :followed, :integer
  end
end
