class QuestionsController < ApplicationController
  QUESTIONS = [
    {
      text: "他人にどう思われてるか、めっちゃ気になる？",
      options: [
        { text: "まったく気にしない", score: 0 },
        { text: "一応気にするけど振り回されない", score: 1 },
        { text: "常に気になっている", score: 2 },
        { text: "人の目でしか自分を見れない", score: 3 }
      ]
    },
    {
      text: "人の意見にすぐ合わせちゃう？",
      options: [
        { text: "自分の意見を優先する", score: 0 },
        { text: "柔軟に意見を取り入れる", score: 1 },
        { text: "だいたい合わせる", score: 2 },
        { text: "自分の考えがわからない", score: 3 }
      ]
    },
    {
      text: "SNSで“いいね”が少ないとちょっと気になる？",
      options: [
        { text: "全然気にしない", score: 0 },
        { text: "少しだけ気になる", score: 1 },
        { text: "かなり気になる", score: 2 },
        { text: "いいねが自己肯定感の基準", score: 3 }
      ]
    },
    {
      text: "何か投稿するとき、タイトルとか言い回しをめっちゃ考える？",
      options: [
        { text: "思いついたまま投稿", score: 0 },
        { text: "多少は気にする", score: 1 },
        { text: "一度下書きにして練る", score: 2 },
        { text: "何度も他人に見せてから投稿", score: 3 }
      ]
    },
    {
      text: "「みんなやってる」はわりと信じがち？",
      options: [
        { text: "まったく影響されない", score: 0 },
        { text: "ちょっと気にする", score: 1 },
        { text: "影響されやすい", score: 2 },
        { text: "「みんな」がすべて", score: 3 }
      ]
    },
    {
      text: "自分の意見を言う前に空気を読む？",
      options: [
        { text: "思ったことをそのまま言う", score: 0 },
        { text: "ある程度読む", score: 1 },
        { text: "かなり慎重に読む", score: 2 },
        { text: "空気に従って生きてる", score: 3 }
      ]
    },
    {
      text: "フォロワー数や反応を気にしてしまう？",
      options: [
        { text: "全く気にしない", score: 0 },
        { text: "増えたらうれしい程度", score: 1 },
        { text: "つい気にしてしまう", score: 2 },
        { text: "常に数字で自己評価", score: 3 }
      ]
    },
    {
      text: "誰かに嫌われてそうだとモヤモヤする？",
      options: [
        { text: "気にしない", score: 0 },
        { text: "たまに気になる", score: 1 },
        { text: "結構ひきずる", score: 2 },
        { text: "夜寝れないくらい気になる", score: 3 }
      ]
    },
    {
      text: "ちょっとでもスベると投稿を消したくなる？",
      options: [
        { text: "消さない", score: 0 },
        { text: "やや気になるが消さない", score: 1 },
        { text: "たまに消す", score: 2 },
        { text: "反応ないとすぐ消す", score: 3 }
      ]
    },
    {
      text: "自分を出すより、周囲の期待に応えるのが先？",
      options: [
        { text: "自分を出す方が大事", score: 0 },
        { text: "場面によって調整する", score: 1 },
        { text: "求められる像に寄せる", score: 2 },
        { text: "自己表現より他人優先", score: 3 }
      ]
    }
  ]

  CHARACTERS = [
    { level: 1, name: "干し椎茸", description: "静かに水分を吸って存在を確かめてます。自己主張ゼロ系。" },
    { level: 5, name: "ちやほやコアラ", description: "可愛がられる自分が好き。でも本気で怒られると樹に登ります。" },
    { level: 9, name: "概念そのもの", description: "あなたは存在であり記号であり、もはや人間というカテゴリでは括れません。" }
  ]

  def index
    @step = (params[:step] || 0).to_i

    session[:question_order] ||= QUESTIONS.shuffle.take(10)
    session[:answers] ||= []

    @question = session[:question_order][@step]

    # 回答を保存（step 0 では何もしない）
    session[:answers][@step - 1] = params[:answer].to_i if @step > 0 && params[:answer].present?

    redirect_to result_path if @question.nil?
  end

  def result
    scores = session[:answers] || []
    total_score = scores.map(&:to_i).sum

    level = case total_score
            when 0..10  then 1
            when 11..17 then 5
            when 18..24 then 7
            else             9
            end

    @character = CHARACTERS.find { |c| c[:level] == level }

    session[:answers] = nil
    session[:question_order] = nil
  end
end
