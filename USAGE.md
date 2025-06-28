# Usage Examples

## Setup

The MetaTagsEngine provides a `Current` model automatically. For apps with existing Current models, add this line:

```ruby
attribute :meta_tags, default: -> { MetaTags.new }
```

## Basic Usage in Views

```erb
<!-- Set basic meta tags -->
<% Current.meta_tags.set(
     title: "About Our Company",
     description: "Learn more about our mission, vision, and team"
   ) %>

<!-- Set meta tags with social media optimization -->
<% Current.meta_tags.set(
     title: "Product Launch",
     description: "Introducing our revolutionary new product",
     image: asset_path("product-hero.jpg"),
     og_type: "article",
     twitter_type: "summary_large_image"
   ) %>
```

## Object-based Meta Tags

```ruby
# In your model (e.g., BlogPost)
class BlogPost < ApplicationRecord
  def to_meta_tags
    {
      title: title,
      description: excerpt.present? ? excerpt : description,
      image: featured_image.attached? ? featured_image.url : nil,
      og_type: "article",
      twitter_type: "summary_large_image"
    }
  end
end

# In your controller or view
<% Current.meta_tags.set_from(@blog_post) %>
```

## Product/E-commerce Meta Tags

```ruby
class Product < ApplicationRecord
  def to_meta_tags
    {
      title: "#{name} - #{price_formatted}",
      description: description.truncate(160),
      image: main_image&.url,
      og_type: "product",
      twitter_type: "summary_large_image"
    }
  end
end
```

## Application Layout

```erb
<!DOCTYPE html>
<html>
  <head>
    <!-- Your meta tags will be rendered here -->
    <%= render Current.meta_tags %>
    
    <!-- Other head elements -->
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>
    <%= stylesheet_link_tag "application" %>
    <%= javascript_importmap_tags %>
  </head>
  <body>
    <%= yield %>
  </body>
</html>
```

## Configuration Examples

```ruby
# config/initializers/meta_tags_engine.rb

MetaTagsEngine.configure do |config|
  # Basic app information
  config.application_name = "My Amazing App"
  
  # Default meta tags for pages that don't set their own
  config.default_title = "My Amazing App - The best app ever"
  config.default_description = "Discover amazing features and join thousands of happy users"
  config.default_image = "opengraph-default.png"
  
  # Social media
  config.default_twitter_site = "@myamazingapp"
end
```

## Advanced Usage

### Custom Separators

```erb
<% Current.meta_tags.set(
     title: "Product Details",
     separator: "•"
   ) %>
<!-- Results in: "Product Details • My Amazing App" -->
```

### SEO-specific Meta Tags

```erb
<% Current.meta_tags.set(
     title: "Blog Post",
     canonical_url: blog_post_url(@post),
     noindex: @post.draft?,
     prev_url: @prev_post ? blog_post_url(@prev_post) : nil,
     next_url: @next_post ? blog_post_url(@next_post) : nil
   ) %>
```

### Mobile/PWA Meta Tags

```erb
<% Current.meta_tags.set(
     theme_color: "#ff6b35",
     web_app_capable: true,
     apple_touch_icon: asset_path("app-icon-180.png")
   ) %>
```
