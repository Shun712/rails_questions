class Admin::QuestionsController < Admin::BaseController
  before_action :set_q, only: %i[index search]

  def index
    if params[:solved] == 'true'
      @q.solved_eq = true
    elsif params[:solved] == 'false'
      @q.solved_eq = false
    end
    @questions =
      @q
        .result(distinct: true)
        .order(created_at: :desc)
        .page(params[:page])
        .per(5)
  end

  def destroy
    @question.destroy
    redirect_to admin_questions_path, notice: "質問「#{@question.title}」を削除しました。"
  end

  def search
    @questions = @q.result.includes(:user).page(params[:page]).per(10)
  end

  private

    def set_q
      @q = Question.ransack(params[:q])
    end
end
