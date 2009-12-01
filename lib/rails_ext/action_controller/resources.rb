module ActionController
  module Resources
    alias :rest_ources :resources

    ACTIONS_TO_OVERRIDE = [:create, :update]

    def resources(*entities, &block)
      options = entities.extract_options!

      options2 = options.dup

      only, except = options2.values_at(:only, :except)

      if only == :none || except == :all # absolutely nothing
        only = []
        except = nil
      elsif only == :all || except == :none || !(only || except) # if nothing in except and only clauses - this means everything
        only = nil
        except = []
      end

      if only
        only_arr = Array(only).map(&:to_sym)
        required = only_arr & ACTIONS_TO_OVERRIDE
        options2[:only] = only_arr - ACTIONS_TO_OVERRIDE
      elsif except
        except_arr = Array(only).map(&:to_sym)
        required = ACTIONS_TO_OVERRIDE - except_arr
        options2[:except] = except_arr + ACTIONS_TO_OVERRIDE
      end

      entities.each { |entity| map_resource(entity, options2, &block) }

      # Then add my own :create and :update routes, if required

      options3 = options.dup

      options3[:except] = options3[:only] = nil

      entities.each { |entity| map_resource_override(entity, required, options3, &block) } unless required.empty?

    end

    private
    def map_resource_override(entities, actions_required, options = {}, &block)
      resource = Resource.new(entities, options)

      with_options :controller => resource.controller do |map|
        map_associations(resource, options)

        if block_given?
          with_options(options.slice(*INHERITABLE_OPTIONS).merge(:path_prefix => resource.nesting_path_prefix, :name_prefix => resource.nesting_name_prefix), &block)
        end

        map_resource_routes(map, resource, :create, resource.new_path, nil, :post) if
                actions_required.include?(:create)
        map_resource_routes(map, resource, :update, "#{resource.member_path}#{resource.action_separator}#{Base.resources_path_names[:edit]}", nil, :post, { :force_id => true }) if
                actions_required.include?(:update)                

      end

    end
  end
end
