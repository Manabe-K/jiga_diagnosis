class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :prepare_meta_tags

  private

  def prepare_meta_tags(options = {})
    site_name   = "自己主張レベル診断"
    title       = options[:title] || "あなたの自己主張、何レベル？"
    description = options[:description] || "“自分らしく、でも空気は読みたい”そんなあなたの“主張レベル”を診断！"
    image_path  = options[:image] || "/ogp.png" # ← public配下を使う
    image_url   = "#{request.base_url}#{image_path}"
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
        image:       image_url
      },
      twitter: {
        card:        'summary_large_image',
        title:       title,
        description: description,
        image:       image_url
      }
    )
  end
end
