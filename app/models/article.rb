class Article < ActiveRecord::Base
  attr_accessible :description, :link, :pub_date, :starred, :title, :channel_id

  belongs_to :channel
  has_many :comments, :foreign_key => :article_hash_tag, :primary_key => :hash_tag

  before_create :generate_hash_tag

  def self.create_from_feed_items items, channel_id
    items.each do |item|
      self.create :link => item.url, :pub_date => item.pub_date, :description => item.summary, :title => item.title, :channel_id => channel_id
    end
  end

  def self.add_from_feed_items items, channel_id
    last_article = self.newest_article channel_id
    items.each do |item|
      new_article = self.new :link => item.url, :pub_date => item.pub_date, :description => item.summary, :title => item.title, :channel_id => channel_id
      if last_article && item.pub_date
        if item.pub_date > last_article.created_at
          new_article.save
        end
      else
        new_article.save
      end
    end
  end

  def self.newest_article channel_id
    channel = Channel.find channel_id
    channel.articles.order('created_at DESC').first
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

  private
  # Generates an MD5 hash from article link
  # to identify multiples articles from it.
  # Used to share comments in different articles
  # that are basically the same.
  def generate_hash_tag
    self.hash_tag = Digest::MD5.hexdigest(self.link)
  end

end
