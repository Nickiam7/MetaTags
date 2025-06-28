require 'spec_helper'

RSpec.describe MetaTagsEngine do
  describe '.configure' do
    it 'yields configuration' do
      expect { |b| described_class.configure(&b) }.to yield_with_args(instance_of(MetaTagsEngine::Configuration))
    end

    it 'sets configuration' do
      described_class.configure do |config|
        config.application_name = 'Configured App'
      end

      expect(described_class.config.application_name).to eq('Configured App')
    end
  end

  describe '.config' do
    it 'returns configuration instance' do
      expect(described_class.config).to be_instance_of(MetaTagsEngine::Configuration)
    end

    it 'returns same instance on multiple calls' do
      config1 = described_class.config
      config2 = described_class.config
      expect(config1).to eq(config2)
    end
  end
end
