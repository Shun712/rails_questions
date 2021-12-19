class Admin::QuestionsController < ApplicationController
  before_action :required_admin
  before_action :set_q, only: %i[index search]

  def index
    @questions = Question.all.page(params[:page]).per(10)
  end

  def destroy
    @question.destroy
    redirect_to questions_url, notice: "質問「#{@question.title}」を削除しました。"
  end

  def search
    @questions = @q.result.includes(:user).page(params[:page]).per(10)
  end

  private

    def required_admin
      redirect_to root_path unless current_user.admin?
    end

    def set_q
      @q = Question.ransack(params[:q])
    end
end
