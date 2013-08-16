class ValidFeedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    feed = FeedManager.instance.get_feed record.url
    unless feed.valid?
      record.errors[attribute] << (options[:message] || 'invalid feed')
    end
  end
end
