require 'tweetstream'
require 'yaml'

ENV["RAILS_ENV"] ||= "development"

TweetStream.configure do |config|
  config.consumer_key        = "v76Gcv7DL2XgVWXMAbTdOy2gp"
  config.consumer_secret     = "zh40GqwJlJEyU1orQqancIpC2I2Y08PcMG2PTdWg6cRaIONJHs"
  config.oauth_token        = "166503030-7deVV6HD9az0KOiqY1MF8o3HG280PK5Vjy4h3FzC"
  config.oauth_token_secret = "Ql8H5jjm6cHhYAishxLOjp0itmKtgFuw9daNiYLeOi6vM"
  config.auth_method 		 = :oauth
end
#puts 'Starting daemon'
daemon = TweetStream::Daemon.new('tracker')

daemon.on_inited do
  ActiveRecord::Base.connection.reconnect!
#  ActiveRecord::Base.logger = Logger.new(File.open('stream.log', 'w+'))
end

daemon.follow(113880398) do |tweet|
  unless status.text[0] == '@'
    record = Post.new
    record.content = tweet.text
    record.title = tweet.id
    record.created_at = tweet.created_at
    record.slug = 'tweet_' + tweet.id.to_s
    record.type = 'tweet'
    record.save
  end
end

daemon.on_error do |message|
  puts message
end