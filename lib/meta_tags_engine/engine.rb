module MetaTagsEngine
  class Engine < ::Rails::Engine
    isolate_namespace MetaTagsEngine

    config.generators do |g|
      g.test_framework :rspec
    end

    initializer "meta_tags_engine.configure_meta_tags", after: :load_config_initializers do |app|
      ActiveSupport::Reloader.to_prepare do
        MetaTags.default_title = MetaTagsEngine.config.default_title
        MetaTags.default_description = MetaTagsEngine.config.default_description
        MetaTags.default_image = MetaTagsEngine.config.default_image
        MetaTags.default_twitter_site = MetaTagsEngine.config.default_twitter_site
      end
    end


  end
end
