class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    @question.user = current_user
    if @question.save
      redirect_to question_path(@question)
    else
      flash[:error] = "Error!"
      render 'new'
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.user == current_user
      if @question.comments
        @question.comments.destroy_all
      end
      if @question.answers
        @question.answers.destroy_all
      end
      @question.destroy
      redirect_to root_path
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.title = question_params["title"]
    @question.content = question_params["content"]
    if @question.save
      redirect_to question_path(@question)
    else
      redirect_to edit_question_path(@question)
      flash[:error] = "Error!"
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
