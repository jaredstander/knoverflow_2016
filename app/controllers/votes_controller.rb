class VotesController < ApplicationController
  def create
    if params.has_key?(:question_id)
      @question = Question.find(params[:question_id])
      vote = @question.votes.new(up_voted: true, voteable_id: @question.id, voteable_type: "question", user_id: current_user.id)
    elsif params.has_key?(:answer_id)
      @answer = Answer.find(params[:answer_id])
      @question = @answer.question
      vote = @answer.votes.new(up_voted: true, voteable_id: @answer.id, voteable_type: "answer", user_id: current_user.id)
    end
    if vote.save
      format.html { redirect_to @comment.post, notice: 'Comment was successfully created.' }
      format.js   { }
      format.json { render :show, status: :created, location: @comment }
    else
      format.html { render :new }
      format.json { render json: @comment.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    if params.has_key?(:question_id)
      @question = Question.find(params[:question_id])
      @vote = @question.votes.where(user_id: current_user.id).first
      @vote.destroy
    elsif params.has_key?(:answer_id)
      @answer = Answer.find(params[:answer_id])
      @question = @answer.question
      @vote = @answer.votes.where(user_id: current_user.id).first
      @vote.destroy
    end
  end
end