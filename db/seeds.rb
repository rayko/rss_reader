# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Creating profile types'
ProfileType.create :name => 'Basic', :channel_limit => 10
ProfileType.create :name => 'Medium', :channel_limit => 20
ProfileType.create :name => 'Premium', :channel_limit => 100

puts 'Finished seeding'
