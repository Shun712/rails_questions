class Admin::QuestionsController < ApplicationController
  before_action :required_admin

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def destroy
    @question.destroy
    redirect_to questions_url, notice: "質問「#{@question.title}」を削除しました。"
  end

  private

    def required_admin
      redirect_to root_path unless current_user.admin?
    end
end
