# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Sext3::Application.load_tasks

namespace :data do
  desc "Delete Data"  
  task :delete => :environment do
    begin
      Chatter.destroy_all
      Organization.destroy_all
      Brand.destroy_all
      Category.destroy_all
      Tag.destroy_all
      User.destroy_all
    end
  end
  
end
