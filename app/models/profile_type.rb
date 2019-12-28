class ProfileType < ActiveRecord::Base
  has_many :users

  def display_name
    "#{self.name} - #{self.channel_limit} channels"
  end

  def self.default_profile
    self.where(:name => 'Basic').first
  end
end
