module Devise
  module Orm
    module Ripple
      module Hook
        def devise_modules_hook!
          extend Schema
          yield
          return unless Devise.apply_schema
          devise_modules.each { |m| send(m) if respond_to?(m, true) }
        end
      end

      module Schema
        include Devise::Schema

        def apply_schema(name, type, options={})
          property name, type, options
        end
      end

    end
  end
end

Ripple::Document::ClassMethods.class_eval do
  include Devise::Models
  include Devise::Orm::Ripple::Hook
end
