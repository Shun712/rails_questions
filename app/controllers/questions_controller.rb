class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to questions_url, notice: "質問「#{@question.title}」を投稿しました。"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @question.update!(question_params)
    redirect_to questions_url, notice: "質問「#{@question.title}」を更新しました。" 
  end

  def destroy
    @question.destroy
    redirect_to questions_url, notice: "質問「#{@question.title}」を削除しました。"
  end

  private

    def question_params
      params.require(:question).permit(:title, :content)
    end

    def set_question
      @question = Question.find(params[:id])
    end
end
