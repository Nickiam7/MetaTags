require_relative "lib/meta_tags_engine/version"

Gem::Specification.new do |spec|
  spec.name        = "meta_tags_engine"
  spec.version     = MetaTagsEngine::VERSION
  spec.authors     = ["Your Name"]
  spec.email       = ["your.email@example.com"]
  spec.homepage    = "https://github.com/yourusername/meta_tags_engine"
  spec.summary     = "A Rails Engine for easy SEO meta tags management"
  spec.description = "A comprehensive Rails Engine that provides easy-to-use meta tags functionality for SEO, including Open Graph and Twitter Cards support."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.0"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rspec-rails"
end
