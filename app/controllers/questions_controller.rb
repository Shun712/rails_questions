class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    question = Question.new(question_params)

    if question.save!
      redirect_to questions_url, notice: "質問「#{question.title}」を投稿しました。"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  private

    def question_params
      params.require(:question).permit(:title, :content)
    end
end
