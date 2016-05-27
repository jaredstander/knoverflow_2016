class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create answer_params
    @comment =  Comment.new
    @answer.user = current_user
    @vote = Vote.new
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: 'Answer Posted.' }
        format.js
        format.json { render json: @answer, status: :created, location: @answer }
      else
        # format.html { render action: "new" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @question = Question.find(@answer.question_id)
    if @answer.user == current_user
      if @answer.comments
        @answer.comments.destroy_all
      end
      @answer.destroy
      redirect_to question_path(@question)
    end
  end

  def edit
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.content = answer_params[:content]
    if @answer.save
      redirect_to question_path(@answer.question)
    else
      redirect_to edit_question_answer_path(@answer)
      flash[:error] = "Error!"
    end
  end

  def answer_params
    params.require(:answer).permit(:content, :question_id, :user_id)
  end
end