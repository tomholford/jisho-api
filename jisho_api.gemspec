lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jisho_api/version"

Gem::Specification.new do |spec|
  spec.name          = "jisho_api"
  spec.version       = JishoAPI::VERSION
  spec.authors       = ["tomholford"]
  spec.email         = ["tomholford@users.noreply.github.com"]

  spec.summary       = 'Ruby client gem for the unofficial Jisho API.'
  spec.homepage      = "https://github.com/tomholford/jisho-api"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = 'https://github.com/tomholford/twitter-labs-api/blob/master/CHANGELOG.md'

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
end
