module ActiveNullObject
  module Finder
    extend ActiveSupport::Concern

    module ClassMethods
      def find_or_null_object(id, options = {})
        null_object_name = options.delete(:null_object)
        null_object = if null_object_name.is_a?(String)
                        null_object_name
                      else
                        "Null#{name.to_s.classify}"
                      end
        find_by(id: id) || null_object.constantize.public_send(ActiveNullObject.initialize_method)
      end
    end
  end
end
