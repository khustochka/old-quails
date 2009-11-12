# http://almosteffortless.com/2009/06/25/config-vars-and-heroku/ for details

desc 'Push the admin_config.yml options for production env as config vars on heroku'
namespace :heroku do
  task :config do
    puts "Reading config/admin_config.yml and sending config vars to Heroku..."
    configs = YAML.load_file('config/admin_config.yml')['production'] rescue {}
    unless configs[:session_secret]
      secret_file = File.join(Rails.root, "config/session_secret")
      if File.exist?(secret_file)
          configs[:session_secret] = File.read(secret_file)
      else
          configs[:session_secret] = ActiveSupport::SecureRandom.hex(64)
          File.open(secret_file, 'w') { |f| f.write(configs[:session_secret]) }
      end
    end
    command = "heroku config:add"
    configs.each {|key, val| command << " #{key}=#{val} " if val }
    puts command
    system command
  end
end
