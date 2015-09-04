require 'active_record'
require 'active_support'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_null_object/association'
require 'active_null_object/create_null_object'
require 'active_null_object/finder'

module ActiveNullObject
  mattr_accessor :initialize_method
  self.initialize_method = 'new'
end

ActiveRecord::Base.send(:include, ActiveNullObject::Association)
ActiveRecord::Base.send(:include, ActiveNullObject::Finder)
