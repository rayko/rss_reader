class Comment < ActiveRecord::Base
  attr_accessible :article_hash_tag, :text, :user_id

  belongs_to :article, :foreign_key => :article_hash_tag, :primary_key => :hash_tag
  belongs_to :user

  validates :text, :presence => true

  def user_username
    self.user.username
  end
end
