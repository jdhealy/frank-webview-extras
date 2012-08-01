# -*- encoding: utf-8 -*-
require File.expand_path('../lib/frank-webview-extras/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["J.D. Healy"]
  gem.email         = ["jdhealy@gmail.com"]
  gem.description   = %q{Extras for Frank for automating UIWebViews}
  gem.summary       = %q{Extras for Frank for automating UIWebViews}
  gem.homepage      = "https://github.com/jdhealy/frank-webview-extras"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "frank-webview-extras"
  gem.require_paths = ["lib"]
  gem.version       = WebView::VERSION
  gem.add_dependency("coffee-script")
end
