# MetaTagsEngine

A comprehensive Rails Engine that provides easy-to-use meta tags functionality for SEO, including Open Graph and Twitter Cards support.

## Features

- 🎯 Easy SEO meta tags management
- 📱 Open Graph protocol support
- 🐦 Twitter Cards support
- 🎨 Customizable defaults
- 🔧 Simple configuration
- 📋 Object-based meta tag assignment
- 🚀 Rails 7+ compatible

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'meta_tags_engine'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install meta_tags_engine
```

After installation, run the generator to set up the engine:

```bash
rails generate meta_tags_engine:install
```

This will create an initializer file at `config/initializers/meta_tags_engine.rb`.

The engine provides a `Current` model with meta_tags functionality automatically.

**For apps with existing Current models, add this line:**
```ruby
attribute :meta_tags, default: -> { MetaTags.new }
```

## Configuration

Configure the engine in `config/initializers/meta_tags_engine.rb`:

```ruby
MetaTagsEngine.configure do |config|
  config.application_name = "My Awesome App"
  config.default_title = "Welcome to My Awesome App"
  config.default_description = "The best app for awesome things"
  config.default_image = "opengraph.png"
  config.default_twitter_site = "@myawesomeapp"
end
```

## Usage

### Basic Usage

In your views, set meta tags like this:

```erb
<% Current.meta_tags.set(title: "About Us", description: "Learn more about our company") %>
```

### Object-based Meta Tags

You can also set meta tags from an object by implementing a `to_meta_tags` method:

```ruby
class BlogPost < ApplicationRecord
  def to_meta_tags
    {
      title: title,
      description: excerpt,
      image: featured_image.present? ? featured_image.url : nil,
      og_type: "article"
    }
  end
end
```

Then in your view:

```erb
<% Current.meta_tags.set_from(@blog_post) %>
```

### Rendering Meta Tags

Add this to your application layout's `<head>` section:

```erb
<%= render Current.meta_tags %>
```

### Available Attributes

You can set the following attributes:

- `site` - Site name (defaults to configured application_name)
- `title` - Page title
- `description` - Page description
- `image` - Image URL or asset pipeline path
- `current_url` - Canonical URL (auto-detected from request)
- `og_type` - Open Graph type (default: "website")
- `twitter_type` - Twitter card type (default: "summary")
- `twitter_site` - Twitter site handle
- `theme_color` - Browser theme color (default: "#ffffff")
- `canonical_url` - Canonical URL override
- `next_url` - Next page URL
- `prev_url` - Previous page URL
- `web_app_capable` - Mobile web app capability (default: true)
- `noindex` - Prevent search engine indexing
- `icons` - Array of favicon configurations
- `apple_touch_icon` - Apple touch icon path
- `separator` - Title separator (default: "|")

### Example Usage

```erb
<% Current.meta_tags.set(
     title: "Product Details",
     description: "Check out this amazing product",
     image: @product.image.url,
     og_type: "product",
     twitter_type: "summary_large_image",
     canonical_url: product_url(@product)
   ) %>
```

### Generated HTML

The engine generates comprehensive meta tags including:

```html
<title>Product Details | My Awesome App</title>
<meta name="title" content="Product Details | My Awesome App">
<meta name="description" content="Check out this amazing product">
<meta property="og:type" content="product">
<meta property="og:url" content="https://example.com/products/1">
<meta property="og:title" content="Product Details | My Awesome App">
<meta property="og:description" content="Check out this amazing product">
<meta property="og:image" content="https://example.com/product-image.jpg">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Product Details | My Awesome App">
<meta name="twitter:description" content="Check out this amazing product">
<meta name="twitter:image" content="https://example.com/product-image.jpg">
<!-- And more... -->
```
## Usage Guide

## Requirements

- Rails 7.0+
- Ruby 3.0+

## Contributing


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
