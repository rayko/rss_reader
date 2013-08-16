class Article < ActiveRecord::Base
  attr_accessible :comment, :description, :link, :pub_date, :starred, :title, :channel_id

  belongs_to :channel
  has_many :comments

  def self.create_from_feed_items items, channel_id
    items.each do |item|
      self.create :link => item.url, :pub_date => item.pub_date, :description => item.description, :title => item.title, :channel_id => channel_id
    end
  end

  def self.add_from_feed_items items, channel_id
    last_article = self.last
    items.each do |item|
      self.create :link => item.url, :pub_date => item.pub_date, :description => item.description, :title => item.title, :channel_id => channel_id if item.pub_date > last_article.put_date
    end
  end

  def mark_as_read
    self.update_attribute :read, true
  end

  def toggle_starred
    if self.starred
      self.update_attribute :starred, false
    else
      self.update_attribute :starred, true
    end

  end

  def belongs_to_user(user)
    self.channel.user_id == user.id
  end

end
