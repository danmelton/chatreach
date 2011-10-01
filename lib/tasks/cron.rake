task :cron => :environment do
  Rake::Task['data:delete'].invoke
  Rake::Task['data:seed'].invoke  
end