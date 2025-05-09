class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :prepare_meta_tags

  private

  def prepare_meta_tags(options = {})
  site_name   = "自己主張レベル診断"
  title       = options[:title] || "あなたの自己主張、何レベル？"
  description = options[:description] || "“自分らしく、でも空気は読みたい”そんなあなたの“主張レベル”を診断！"
  image       = options[:image] || view_context.image_url("ogp.png")
  current_url = options[:url] || request.original_url

  set_meta_tags(
    site:        site_name,
    title:       title,
    description: description,
    og: {
      title:       title,
      description: description,
      type:        'website',
      url:         current_url,
      image:       image
    },
    twitter: {
      card:        'summary_large_image',
      title:       title,
      description: description,
      image:       image
    }
  )
end
end
