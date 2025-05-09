class ShareController < ApplicationController
  CHARACTERS = SelfEgoTest::Characters::LIST

  def show
    level = params[:id].to_i
    @character = CHARACTERS.find { |c| c[:level] == level }

    # public/ogp_levels に配置された画像URLを生成
    og_image = "#{request.base_url}/ogp_levels/level#{level}.png"

    prepare_meta_tags(
      title:       "Lv.#{level}「#{@character[:name]}」でした！",
      description: @character[:description],
      image:       og_image,
      url:         root_url # ← ここを変えるとシェア先URLも変わる
    )
  end
end