require 'rails/generators/base'

module MetaTagsEngine
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc "Creates MetaTagsEngine initializer"

      def copy_initializer
        template "meta_tags_engine.rb", "config/initializers/meta_tags_engine.rb"
      end

      def show_readme
        readme "INSTALL_README" if behavior == :invoke
      end
    end
  end
end
