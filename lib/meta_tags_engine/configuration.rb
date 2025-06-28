module MetaTagsEngine
  class Configuration
    attr_accessor :application_name, :default_title, :default_description,
                  :default_image, :default_twitter_site

    def initialize
      @application_name = "My App"
      @default_title = nil
      @default_description = nil
      @default_image = nil
      @default_twitter_site = nil
    end
  end
end
