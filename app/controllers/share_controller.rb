class ShareController < ApplicationController
  CHARACTERS = SelfEgoTest::Characters::LIST

  def show
    level = params[:id].to_i
    @character = CHARACTERS.find { |c| c[:level] == level }
    render layout: false
  end
end