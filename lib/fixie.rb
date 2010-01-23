require 'active_record/fixtures'

# Based on Fixie plugin Copyright (c) 2009 Luke Francl (look@recursion.org)
# http://github.com/look/fixie
module Fixie
  def self.create(model, label, *attrs)
    obj = Factory.build(model, *attrs)

    obj.id = Fixtures.identify(label)
    obj.save!
    
    obj
  end

  def self.method_missing(symbol, args, &blck)
    find(symbol, args)
  end

  def self.find(table_name, identifier)
    table_name.to_s.classify.constantize.find(Fixtures.identify(identifier))
  end
end
