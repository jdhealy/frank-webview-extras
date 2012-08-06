# -*- encoding: utf-8 -*-
#require File.expand_path('../lib/frank-webview-extras/version', __FILE__)
$:.unshift File.expand_path("../lib", __FILE__)
require 'frank-webview-extras/version'

Gem::Specification.new do |gem|
  gem.authors       = ["J.D. Healy"]
  gem.email         = ["jdhealy@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "frank-webview-extras"
  gem.require_paths = ["lib"]
  gem.version       = WebView::VERSION
  gem.add_dependency("coffee-script")
end
