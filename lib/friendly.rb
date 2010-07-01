require 'friendly/associations'
require 'friendly/attribute'
require 'friendly/benchmarking'
require 'friendly/boolean'
require 'friendly/cache'
require 'friendly/cache/by_id'
require 'friendly/data_store'
require 'friendly/document'
require 'friendly/document_table'
require 'friendly/index'
require 'friendly/indexer'
require 'friendly/logger'
require 'friendly/logging'
require 'friendly/memcached'
require 'friendly/query'
require 'friendly/sequel_monkey_patches'
require 'friendly/scope'
require 'friendly/scope_proxy'
require 'friendly/storage_factory'
require 'friendly/storage_proxy'
require 'friendly/storage_set'
require 'friendly/translator'
require 'friendly/uuid'

require 'will_paginate/collection'

module Friendly
  class << self
    attr_accessor :datastore, :db, :cache, :logger

    def configure(config)
      config[:logger] ||= Friendly::Logger.new("/dev/null", Logger::INFO)
      self.logger       = config[:logger]
      self.db           = Sequel.connect(config)
      self.datastore    = DataStore.new(db)

      require 'friendly/benchmark_sql' if config[:benchmark_sql]
    end

    def batch
      begin
        datastore.start_batch
        yield
        datastore.flush_batch
      ensure
        datastore.reset_batch
      end
    end

    def create_tables!
      Document.create_tables!
    end
  end

  class Error < RuntimeError; end
  class RecordNotFound < Error; end
  class MissingIndex < Error; end
  class NoConverterExists < Friendly::Error; end
  class NotSupported < Friendly::Error; end
end
