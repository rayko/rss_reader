class Article < ActiveRecord::Base
  attr_accessible :comment, :description, :link, :pub_date, :starred, :title, :channel_id

  belongs_to :channel

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
end