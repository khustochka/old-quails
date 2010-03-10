module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      '/'

    when /Admin dashboard/
      "/admin/#{CONFIG[:admin_dashboard]}"

    when /(Ordines|Familiae) Index/
      "/admin/#{$1.downcase}"

    when /the new (ordo|familia|species) page/
      "/admin/#{$1.pluralize}/new"

    when /'([^']*)'/
      $1

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
