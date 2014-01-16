require 'active_record'
require 'active_support'

module ActiveNullObject
  extend ActiveSupport::Concern

  included do
    class << self
      alias_method_chain :belongs_to, :null_object
    end
  end

  module ClassMethods
    def belongs_to_with_null_object(name, scope = nil, options = {})
      null_object_name = extract_null_object_from_options(scope, options)
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
        super() || null_object.constantize.new
      end
    end

    private

    def extract_null_object_from_options(scope, options)
      if scope.is_a?(Hash)
        scope.delete(:null_object)
      else
        options.delete(:null_object)
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveNullObject)
