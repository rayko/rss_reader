class Channel < ActiveRecord::Base
  attr_accessible :title, :url

  belongs_to :user

  before_save :set_title

  private
  def set_title
    self.title = 'My Channel' # should be something else
  end
end
