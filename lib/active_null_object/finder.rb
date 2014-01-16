module ActiveNullObject
  module Finder
    extend ActiveSupport::Concern

    module ClassMethods
      def find_or_null_object(id)
        find_by(id: id) || "Null#{name}".constantize.new
      end
    end
  end
end
