class QuestionsController < ApplicationController
  def index
    @questions = Question.order("vote_count DESC")
    @vote = Vote.new
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
      flash[:error] = @question.errors.messages
      puts @question.errors.messages
      render 'new'
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.order("vote_count DESC")
    @answer = @question.answers.build
    @question_comments = @question.comments.all
    @answer_comments = @answer.comments.all
    @comment = Comment.new
    @vote = Vote.new
  end

  def destroy
    @question = Question.find(params[:id])
    redirect_to root_path unless User.find(@question.user_id) == current_user
    @question.destroy
    redirect_to root_path
  end

  def edit
    @question = Question.find(params[:id])
    redirect_to root_path unless User.find(@question.user_id) == current_user
  end

  def update
    @question = Question.find(params[:id])
    redirect_to root_path unless User.find(@question.user_id) == current_user
    @question.title = question_params["title"]
    @question.content = question_params["content"]
    if @question.save
      redirect_to question_path(@question)
    else
      redirect_to edit_question_path(@question)
      flash[:error] = @question.errors.messages
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
