class UniqUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.user.channels.collect{ |c| c.url }.include? value
      record.errors[attribute] << (options[:message] || 'channel already exists')
    end
  end
end
