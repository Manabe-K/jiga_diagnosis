class ShareController < ApplicationController
  CHARACTERS = SelfEgoTest::Characters::LIST

  def show
    level = params[:id].to_i
    @character = CHARACTERS.find { |c| c[:level] == level }

    og_image = view_context.image_url("ogp_levels/level#{level}.png")
    prepare_meta_tags(
      title:       "Lv.#{level}「#{@character[:name]}」でした！",
      description: @character[:description],
      image:       og_image,
      url:         root_url # ← これがシェア時のリンク先になる
    )
  end
end