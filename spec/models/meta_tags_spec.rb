require 'spec_helper'

RSpec.describe MetaTags do
  let(:meta_tags) { described_class.new }
  let(:view_context) do
    double('view_context',
           request: double(url: 'https://example.com/test'),
           content_for: nil,
           image_url: ->(path) { "https://example.com/#{path}" },
           render: '<meta tags>'
    )
  end

  before do
    MetaTagsEngine.configure do |config|
      config.application_name = "Test App"
      config.default_title = "Default Title"
      config.default_description = "Default Description"
    end
  end

  describe '#set' do
    it 'sets attributes from hash' do
      meta_tags.set(title: 'New Title', description: 'New Description')
      
      expect(meta_tags.title).to eq('New Title')
      expect(meta_tags.description).to eq('New Description')
    end

    it 'ignores blank values' do
      meta_tags.set(title: 'New Title', description: '')
      
      expect(meta_tags.title).to eq('New Title')
      expect(meta_tags.description).to eq('Default Description')
    end
  end

  describe '#set_from' do
    let(:object_with_meta_tags) do
      double('object', to_meta_tags: { title: 'Object Title', description: 'Object Description' })
    end

    it 'sets attributes from object' do
      meta_tags.set_from(object_with_meta_tags)
      
      expect(meta_tags.title).to eq('Object Title')
      expect(meta_tags.description).to eq('Object Description')
    end
  end

  describe '#render_in' do
    it 'renders meta tags with view context' do
      meta_tags.set(title: 'Test Page', description: 'Test Description')
      
      expect(view_context).to receive(:render).with(
        inline: anything,
        locals: hash_including(full_title: 'Test Page | Test App')
      )
      
      meta_tags.render_in(view_context)
    end

    it 'handles external image URLs' do
      meta_tags.set(image: 'https://external.com/image.jpg')
      
      expect(view_context).to receive(:render).with(
        inline: anything,
        locals: hash_including(image_url: 'https://external.com/image.jpg')
      )
      
      meta_tags.render_in(view_context)
    end

    it 'converts asset pipeline images to full URLs' do
      meta_tags.set(image: 'logo.png')
      
      expect(view_context).to receive(:render).with(
        inline: anything,
        locals: hash_including(image_url: 'https://example.com/logo.png')
      )
      
      meta_tags.render_in(view_context)
    end
  end

  describe 'default values' do
    it 'uses configured application name for site' do
      expect(meta_tags.site).to eq('Test App')
    end

    it 'uses default title from class attribute' do
      described_class.default_title = 'Class Default Title'
      new_meta_tags = described_class.new
      expect(new_meta_tags.title).to eq('Class Default Title')
    end
  end
end
