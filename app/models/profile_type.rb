class ProfileType < ActiveRecord::Base
  attr_accessible :channel_limit, :name

  has_many :users

  def display_name
    "#{self.name} - #{self.channel_limit} channels"
  end

  def self.default_profile
    self.where(:name => 'Basic').first
  end
end
