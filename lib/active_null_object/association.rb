module ActiveNullObject
  module Association
    extend ActiveSupport::Concern

    included do
      class << self
        alias_method_chain :belongs_to, :null_object
      end
    end

    module ClassMethods
      def belongs_to_with_null_object(name, scope = nil, options = {})
        options = scope if scope.is_a?(Hash)
        null_object_name = options.delete(:null_object)
        belongs_to_without_null_object(name, scope, options)
        define_null_object_getter(name, null_object_name) if null_object_name
      end

      def define_null_object_getter(name, null_object_name)
        null_object = if null_object_name.is_a?(String)
                        null_object_name
                      else
                        "Null#{name.to_s.classify}"
                      end
        define_method(name) do
          super() || null_object.constantize.public_send(ActiveNullObject.initialize_method)
        end
      end
    end
  end
end
