require_relative 'test_helper'
require 'rack/cache/request'

describe Rack::Cache::Request do
  it 'is marked as no_cache when the cache-control header includes the no-cache directive' do
    request = Rack::Cache::Request.new('HTTP_CACHE_CONTROL' => 'public, no-cache')
    assert request.no_cache?
  end

  it 'is marked as no_cache when request should not be loaded from cache' do
    request = Rack::Cache::Request.new('HTTP_PRAGMA' => 'no-cache')
    assert request.no_cache?
  end

  it 'is not marked as no_cache when neither no-cache directive is specified' do
    request = Rack::Cache::Request.new('HTTP_CACHE_CONTROL' => 'public')
    refute request.no_cache?
  end
end
