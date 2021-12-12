class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @user = @question.user
    @answer = @question.answers.build(user_id: current_user.id, content: params[:answer][:content])
    if !@question.nil? && @answer.save
      flash[:success] = "コメントを追加しました！"
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
