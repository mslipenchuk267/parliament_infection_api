# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

ENV.each_key do |key|
    env key.to_sym, ENV[key]
end

set :environment, ENV["RAILS_ENV"]

case @environment

    when 'production'
        set :output, "log/cron_production.log"

        every :day, at: '12:00 pm' do
            rake 'clean_infections:clean_infections'
        end

    when 'development'
        set :output, "log/cron_development.log"
        set :job_template, "zsh -l -c ':job'"
        job_type :rbenv_rake, %Q{export PATH=/opt/rbenv/shims:/opt/rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; \
            cd :path && bundle exec rake :task --silent :output }
        every :day, at: '12:00 pm' do
            rbenv_rake 'clean_infections:clean_infections'
        end
    
end