require File.join(Rails.root, "lib/legacy/legacy_task")

desc 'Tasks for legacy site DB'
namespace :legacy do
  namespace :db do
    task( :import => :environment ) do
      legacy_task = LegacyTask.new

      puts "Export started"
      legacy_task.export

      puts "Import started"
      legacy_task.import

    end
  end
end
