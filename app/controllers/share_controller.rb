class ShareController < ApplicationController
  CHARACTERS = SelfEgoTest::Characters::LIST

  def show
    level = params[:id].to_i
    @character = CHARACTERS.find { |c| c[:level] == level }

    og_image_url = view_context.image_url("ogp_levels/level#{level}.png")
    prepare_meta_tags(
      title:       "Lv.#{level}「#{@character[:name]}」でした！",
      description: @character[:description],
      image:       og_image_url
    )

    # OGP出力後、リダイレクト（表示はしない）
    render layout: "share"
  end
end