class RemoveArticleLinkFromComments < ActiveRecord::Migration
  def up
    remove_column :comments, :article_link
  end

  def down
    add_column :comments, :article_link, :string
  end
end
