class AddHashesToArticlesAndCommentsAndCleanup < ActiveRecord::Migration
  def up
    remove_column :comments, :article_id
    add_column :articles, :hash_tag, :string
    add_column :comments, :article_hash_tag, :string
  end

  def down
    add_column :comments, :article_id, :integer
    remove_column :articles, :hash_tag
    remove_column :comments, :article_hash_tag
  end
end
