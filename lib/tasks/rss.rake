namespace :rss do
  desc "Updates channel feeds"
  task :update_feeds => :environment do
    puts '-.Feed update starting.-'
    Channel.all.each do |channel|
      puts "Beginning feed request at #{channel.url}..."
      channel.update_feed
      puts "Request done. #{channel.url} updated!"
    end
    puts '-.Feed update finished.-'
  end

  desc "Generates daily mails and send them to users"
  task :send_daily_mails => :environment do
  end

end
