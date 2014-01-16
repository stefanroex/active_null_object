Active Null Record
==================

Instead of returning nil when an association is not found, return a [Null Object](http://martinfowler.com/eaaCatalog/specialCase.html).

```ruby
# Automatically searches for the Null Object based on the association name (NullUser)...
belongs_to :user, null_object: true

# ...or pass explicit class name.
belongs_to :user, null_object: 'NullAdmin'
```
