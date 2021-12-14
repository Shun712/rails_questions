class SampleMailer < ApplicationMailer
  default from: "sample@example.com"

  def send_when_question
    @user_from = params[:user_from]
    @user_to = params[:user_to]
    @question = params[:question]
    mail(to: "#{@user_to}.email", subject: "#{@user_from}さんが質問を投稿しました。")
  end

  def send_when_answer
    @user_from = params[:user_from]
    @user_to = params[:user_to]
    @answer = params[:answer]
    mail(to: "#{@user_to}.email", subject: "#{@user_from}さんが回答を投稿しました。")
  end
end
