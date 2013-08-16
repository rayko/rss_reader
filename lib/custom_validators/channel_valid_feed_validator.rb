class ValidFeedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    feed = FeedManager.new.get_items record.url
    unless feed.valid?
      record.errors[attribute] << (options[:message] || 'invalid feed')
    end
  end
end
