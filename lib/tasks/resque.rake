require 'resque/tasks'

namespace :resque do
  task :setup do
    require 'resque'
    ENV['QUEUE'] = '*'

    Resque.redis = 'localhost:6379' unless Rails.env == 'production'
    Resque::Scheduler.dynamic = true



  end
end

Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }
