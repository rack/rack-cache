require_relative 'lib/rack/cache/version'

Gem::Specification.new do |s|
  s.name = "rack-cache"
  s.version = Rack::Cache::VERSION

  s.summary     = "HTTP Caching for Rack"
  s.description = "Rack::Cache is suitable as a quick drop-in component to enable HTTP caching for Rack-based applications that produce freshness (expires, cache-control) and/or validation (last-modified, etag) information."
  s.required_ruby_version = '>= 2.7.7'

  s.authors = ["Ryan Tomayko"]
  s.email = "r@tomayko.com"

  s.files = `git ls-files lib/ README.md MIT-LICENSE`.split("\n")
  s.extra_rdoc_files = %w[README.md MIT-LICENSE CHANGES]

  s.add_dependency 'rack', '>= 0.4'

  s.add_development_dependency 'maxitest'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'mutex_m'
  s.add_development_dependency 'dalli'
  s.add_development_dependency 'bump'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'hanna-nouveau'

  s.license = "MIT"
  s.homepage = "https://github.com/rack/rack-cache"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Rack::Cache", "--main", "Rack::Cache"]
end
