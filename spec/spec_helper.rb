require 'bundler'
require 'active_record'
require 'active_null_object'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order = "random"
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

ActiveRecord::Base.establish_connection 'sqlite3:///:memory:'
ActiveRecord::Base.connection.instance_eval do
  create_table('users')

  create_table('posts') do |t|
    t.integer :user_id
  end

  create_table('comments') do |t|
    t.integer :user_id
  end

  create_table('messages') do |t|
    t.integer :user_id
  end
end

class NullUser
end

class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :messages
end

class Post < ActiveRecord::Base
  belongs_to :user
end

class Comment < ActiveRecord::Base
  belongs_to :user, null_object: 'NullUser'
end

class Message < ActiveRecord::Base
  belongs_to :user, null_object: true
end
