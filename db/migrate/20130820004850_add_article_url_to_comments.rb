class AddArticleUrlToComments < ActiveRecord::Migration
  def change
    add_column :comments, :article_link, :string
  end
end
