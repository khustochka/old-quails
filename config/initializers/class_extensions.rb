%w(object string).each do |inc_ext|
  require File.join(Rails.root, "lib/core_ext/#{inc_ext}")
end

%w(base).each do |inc_ext|
  require File.join(Rails.root, "lib/rails_ext/action_controller/#{inc_ext}")
end

%w(base helpers).each do |inc_ext|
  require File.join(Rails.root, "lib/rails_ext/action_view/#{inc_ext}")
end