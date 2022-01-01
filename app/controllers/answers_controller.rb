class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @answer = current_user.answers.build(answer_params.merge(question_id: @question.id))
    if @answer.save
      unless current_user == @question.user
        SampleMailer.with(user_from: current_user,
                          user_to: @question.user,
                          answer: @answer).send_when_answer.deliver_now
      end
      answered_users = User.joins(:answers).where(answers: {question_id: @question.id}).distinct
      answered_users.each do |user|
        next if user == current_user || user == @question.user
        SampleMailer.with(user_from: current_user,
                          user_to: user,
                          answer: @answer).send_when_answer.deliver_now
      end     
      redirect_to @question, notice: "回答をコメントしました!"             
    else
      flash[:danger] = "空の回答は投稿できません。"
    end
  end

  private

    def answer_params
      params.require(:answer).permit(:content)
    end
end
