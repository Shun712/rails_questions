class QuestionsController < ApplicationController
  before_action :set_question, only: %i[edit update destroy]
  before_action :set_q, only: %i[index search]
  
  def index
    if params[:solved_check] == 'false'
      @q.solved_check = false
    elsif params[:solved_check] == 'true'
      @q.solved_check = true
    end
    set_questions
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      receivers = User.where.not(id: current_user.id)
      receivers.each do |user|
        SampleMailer.with(user_from: current_user,
                          user_to: user,
                          question: @question).send_when_question.deliver_now
      end
      redirect_to questions_url, notice: "質問「#{@question.title}」を投稿しました。"
    else
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.includes(:user).order(created_at: :asc)
    @answer = Answer.new
  end

  def edit
  end

  def update
    if current_user?(@question.user)
      if @question.update(question_params)
        redirect_to @question, notice: "質問「#{@question.title}」を更新しました。" 
      else
        render :edit
      end
    else
      render :edit, notice: "他人の質問を更新できません。"
    end
  end

  def destroy
    if current_user?(@question.user)
      if @question.destroy
         redirect_to questions_url, notice: "質問「#{@question.title}」を削除しました。"
      else
        render :edit
      end
    else
      render :edit, notice: "他人の質問を削除できません。"
    end
  end

  def search
    set_questions
  end

  private

    def question_params
      params.require(:question).permit(:title, :content, :solved_check)
    end

    def set_question
      @question = current_user.questions.find(params[:id])
    end

    def set_q
      @q = Question.ransack(params[:q])
    end

    def set_questions
      @questions = @q
                     .result(distinct: true)
                     .order(created_at: :desc)
                     .page(params[:page])
                     .per(10)
    end
end
