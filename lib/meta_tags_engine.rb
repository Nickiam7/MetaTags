require "meta_tags_engine/version"
require "meta_tags_engine/engine"
require "meta_tags_engine/configuration"

module MetaTagsEngine
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.config
    configuration || Configuration.new
  end
end
