class QuestionsController < ApplicationController
  QUESTIONS = SelfEgoTest::Questions::LIST
  CHARACTERS = SelfEgoTest::Characters::LIST

  def index
    @step = (params[:step] || 0).to_i
    session[:question_order] ||= (0...QUESTIONS.size).to_a.shuffle.take(7)
    session[:answers] ||= []

    if @step > 0 && params[:answer].present? && params[:commit] != "戻る"
      session[:answers][@step - 1] = params[:answer].to_i
    end

    if @step >= session[:question_order].size
      session[:answers][@step - 1] ||= params[:answer].to_i if params[:answer].present?
      redirect_to analyzing_path and return
    end

    @question = QUESTIONS[session[:question_order][@step]]
  end

  def analyzing
  end

  def result
    scores = session[:answers] || []
    total_score = scores.sum

    level = score_to_level(total_score)
    @character = CHARACTERS.find { |c| c[:level] == level }

    # OGPは share#show 側で処理されるためここでは不要
  end

  private

  def score_to_level(score)
    case score
    when 0..2   then 1
    when 3..5   then 2
    when 6..8   then 3
    when 9..11  then 4
    when 12..14 then 5
    when 15..17 then 6
    when 18..20 then 7
    when 21..23 then 8
    when 24..26 then 9
    else             10
    end
  end
end
