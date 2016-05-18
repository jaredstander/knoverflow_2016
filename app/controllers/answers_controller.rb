class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build
    @answer.user_id = current_user.id
    @answer.content = answer_params[:content]
    if @answer.save
      redirect_to question_path(@question)
      # render json: {html: render_to_string(partial: 'answer', locals: {answer: @answer})}
    else
      redirect_to question_path(@question)
      # question = Question.find(@answer.question_id)
      # render json: {html: render_to_string(partial: 'question/show', locals: {question: @question, answer: @answer})}
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