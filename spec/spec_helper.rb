if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require 'bundler/setup'
require 'active_null_object'

if ActiveRecord.version >= Gem::Version.new('4.1.0')
  ActiveRecord::Base.establish_connection 'sqlite3::memory:'
else
  ActiveRecord::Base.establish_connection 'sqlite3:///:memory:'
end

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

class Guest
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

RSpec.configure do |config|
  config.order = 'random'
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before do
    ActiveRecord::Base.connection.begin_transaction joinable: false
  end

  config.after do
    ActiveRecord::Base.connection.rollback_transaction
  end
end
