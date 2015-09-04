Active Null Object
==================

[![Build Status](https://travis-ci.org/stefanroex/active_null_object.svg)](https://travis-ci.org/stefanroex/active_null_object)

Instead of returning nil when an association is not found, return a [Null Object](http://martinfowler.com/eaaCatalog/specialCase.html).

Associations
------------
```ruby
# Automatically searches for the Null Object based on the association name (NullUser)...
belongs_to :user, null_object: true

# ...or pass explicit class name.
belongs_to :user, null_object: 'NullAdmin'
```

Finder
------
```ruby
# Use a specialized finder if you want a Null Object if the record is not found.
User.find_or_null_object(1)

# ...or pass explicit class name.
User.find_or_null_object(1, null_object: 'NullAdmin')
```
