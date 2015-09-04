module ActiveNullObject
  module Association
    extend ActiveSupport::Concern

    included do
      class << self
        alias_method_chain :belongs_to, :null_object
      end
    end

    module ClassMethods
      def belongs_to_with_null_object(relation_name, scope = nil, options = {})
        options = scope if scope.is_a?(Hash)
        null_object_name = options.delete(:null_object)
        belongs_to_without_null_object(relation_name, scope, options)
        if null_object_name
          define_null_object_getter(relation_name, null_object_name)
        end
      end

      def define_null_object_getter(relation_name, custom_name)
        create_null_object = CreateNullObject.new(relation_name, custom_name)
        define_method(relation_name) do
          super() || create_null_object.call
        end
      end
    end
  end
end
