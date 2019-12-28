class Comment < ActiveRecord::Base
  belongs_to :article, :foreign_key => :article_hash_tag, :primary_key => :hash_tag
  belongs_to :user

  validates :text, :article_hash_tag, :presence => true

  def user_username
    self.user.username
  end
end
