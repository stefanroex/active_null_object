module ActiveNullObject
  module Finder
    extend ActiveSupport::Concern

    module ClassMethods
      def find_or_null_object(id, options = {})
        custom_name = options.delete(:null_object)
        find_by(id: id) || CreateNullObject.new(name, custom_name).call
      end
    end
  end
end
