class FeedItem
  attr_accessor :title, :url, :summary, :pub_date

  def initialize(title, url, summary, pub_date)
    self.title = title
    self.url = url
    self.summary = summary
    self.pub_date = pub_date || DateTime.now
  end

  def published
    self.pub_date
  end
end
