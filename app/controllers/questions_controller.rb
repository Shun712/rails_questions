class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    if params[:solved_check] == 'false'
      @questions = Question.where(solved_check: false)
    elsif params[:solved_check] == 'true'
      @questions = Question.where(solved_check: true)
    else
      @questions = Question.all
    end
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
    @answers = @question.answers.includes(:user).order(created_at: :desc)
    @answer = Answer.new
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
      params.require(:question).permit(:title, :content, :solved_check)
    end

    def set_question
      @question = Question.find(params[:id])
    end
end
