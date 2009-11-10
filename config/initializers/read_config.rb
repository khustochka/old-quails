require 'yaml'

# read config from yml and merge with ENV (for heroku)
configs  = (YAML.load_file('config/config.yml')[RAILS_ENV] rescue {})
configs = configs.merge((YAML.load_file('admin_config/config.yml')[RAILS_ENV] rescue {}))
CONFIG = configs.merge(ENV).symbolize_keys