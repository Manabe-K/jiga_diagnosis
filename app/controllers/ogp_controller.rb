# app/controllers/ogp_controller.rb
class OgpController < ApplicationController
  CHARACTERS = SelfEgoTest::Characters::LIST

  def show
    @character = CHARACTERS.find { |c| c[:level] == params[:id].to_i }
    render layout: "ogp"
  end
end
