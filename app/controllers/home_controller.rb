class HomeController < ApplicationController
  def index
    # 診断開始前にセッションをクリアしておく
    reset_session
  end
end
