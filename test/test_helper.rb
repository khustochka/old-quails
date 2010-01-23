ENV['RAILS_ENV'] = 'test'
require 'config/environment'
require 'test_help'
require 'shoulda'
require 'spec'
require 'factory_girl'

class ActiveSupport::TestCase
  include Spec::Matchers
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
#  fixtures :all

  # Add more helper methods to be used by all tests here...

  def http_auth
    unless CONFIG[:open_access]
      session[CONFIG[:admin_session_ask].to_sym] = CONFIG[:admin_session_reply]
      @request.env["HTTP_AUTHORIZATION"] = "Basic #{Base64.encode64("#{CONFIG[:admin_username]}:#{CONFIG[:admin_password]}")}"
    end
  end

  def be_sorted
    simple_matcher do |klass|
      sort_column = klass.get_sort_column
      if klass.top_level?
        klass.all(:select => sort_column, :order => sort_column).map {|item| item[sort_column] }.should == Array(1..klass.count)
      else
        klass.parent_class.all(:order => klass.parent_class.get_sort_column, :include => :children).each do |parent|
          parent.children.map {|item| item[sort_column] }.sort.should == Array(1..parent.children.size)
        end
      end
    end
  end


end
