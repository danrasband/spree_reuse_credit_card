class AddUserIdToCreditcard < ActiveRecord::Migration
  def change
    add_column :spree_creditcards, :user_id, :integer
    add_index :spree_creditcards, :user_id
  end
end
