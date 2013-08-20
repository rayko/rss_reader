namespace :rss do
  desc "Updates channel feeds"
  task :update_feeds => :environment do
    Rails.logger.info 'rss:update_feed Feed update starting'
    Channel.all.each do |channel|
      Rails.logger.info "rss:update_feed Beginning feed request at #{channel.url}..."
      channel.update_feed
      Rails.logger.info "rss:update_feed Request done. #{channel.url} updated!"
    end
    Rails.logger.info 'rss:update_feed Feed update finished!'
  end

  desc "Generates daily mails and send them to users"
  task :send_daily_mails => :environment do
  end

end
