class ChannelLimitValidator < ActiveModel::Validator
  def validate(record)
    if record.user.channel_ids.size >= record.user.channel_limit
      record.errors[:base] << "Reached maximun channels limit by your profile. Can't create another channel."
    end
  end
end
