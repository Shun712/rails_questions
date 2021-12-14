class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @user = @question.user
    @answer = @question.answers.build(user_id: current_user.id, content: params[:answer][:content])
    if !@question.nil? && @answer.save
      flash[:success] = "コメントを追加しました！"
      receivers = User.where(id: @question.user).where(id: @answer.user).where.not(id: current_user.id).distinct
      SampleMailer.with(user_from: current_user,
                        user_to: receivers,
                        answer: @answer).send_when_answer.deliver_now
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to question_path(@question)
  end

  private

    def answer_params
      params.require(:answer).permit(:content)
    end
end
