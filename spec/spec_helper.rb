require 'simplecov'
SimpleCov.start

require 'saver'
require 'mongo_mapper'
MongoMapper.connection = Mongo::Connection.new
MongoMapper.database = 'saver_test'

