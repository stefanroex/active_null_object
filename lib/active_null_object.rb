require 'active_record'
require 'active_support'
require 'active_null_object/association'
require 'active_null_object/finder'

module ActiveNullObject
end

ActiveRecord::Base.send(:include, ActiveNullObject::Association)
ActiveRecord::Base.send(:include, ActiveNullObject::Finder)
