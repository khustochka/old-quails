# Taken from http://github.com/look/fixie
namespace :db do
  namespace :test do
    desc 'Causes db:test:prepare to also run the fixture creation files in test/fixtures'
    # Somewhat obscure(?) fact: if you create a rake task with the
    # same name as another one (in this case test:db:prepare), it will
    # be run after the first one. That's how this works.
    task :prepare do
      RAILS_ENV = 'test'
      load 'test/unit/sorted_hierarchy/schema.rb'
      Dir[File.join(RAILS_ROOT, 'test', 'fixtures', '*.rb')].sort.each { |fixture| load fixture }
    end
  end
end