class Comment < ActiveRecord::Base
  attr_accessible :article_id, :text, :user_id

  belongs_to :article
  belongs_to :user

  validates :text, :presence => true

  def user_username
    self.user.username
  end
end
