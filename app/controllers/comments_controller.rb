class CommentsController < ApplicationController

  def create
    if params.has_key?('question_id')
      question = Question.find(params[:question_id])
      comment = question.comments.new comment_params
      comment.user_id = current_user.id
      if comment.save
        # render json: {
        #   html: render_to_string(partial: 'comments', locals: {commentable: question})
        # }
        redirect_to question_path(question)
      else
        # render json: {
        #   html: render_to_string(partial: 'form', locals: { commentable: question, comment: comment })
        # }, status: :unprocessable_entity
        redirect_to question_path(question)
      end
    elsif params.has_key?('answer_id')
      answer = Answer.find(params[:answer_id])
      comment = answer.comments.new (params[:comment])
      comment.user_id = current_user.id
      if comment.save
        # render json: {
        #   html: render_to_string(partial: 'comments', locals: { commentable: answer})
        # }
        redirect_to question_path(answer.question)
      else
        # render json: {
        #   html: render_to_string(partial: 'form', locals: { commentable: answer, comment: comment })
        # }, status: :unprocessable_entity
        redirect_to question_path(answer.question)
      end
    end
  end

  def destroy
    if params.has_key?("question_id")
      @comment = Comment.find(params["id"])
      if @comment.user == current_user
        @comment.destroy
      end
      @question = Question.find(@comment.commentable_id)
      redirect_to question_path(@question)
    else
      @comment = Comment.find(params["id"])
      if comment.user = current_user
        @comment.destroy
      end
      @answer = Answer.find(@comment.commentable_id)
      redirect_to question_path(@answer.question)
    end
  end

  def edit
    if params.has_key?("question_id")
      @comment = Comment.find(params["id"])
      @commentable = [Question.find(params["question_id"])]
    else
      @comment = Comment.find(params["id"])
      @answer = Answer.find(params["answer_id"])
      @question = @answer.question
      @commentable = [@question, @answer]
    end
  end

  def update
    if params.has_key?("question_id")
      @comment = Comment.find(params["id"])
      @question = Question.find(params["question_id"])
    else
      @comment = Comment.find(params["id"])
      @answer = Answer.find(params["answer_id"])
      @question = @answer.question_id
    end

    @comment.content = params["comment"]["content"]

    if @comment.save
      redirect_to question_path(@question)
    else
      flash[:error] = "Error!"
      if params.has_key?("question_id")
        redirect_to edit_question_comment_path(@question, @comment)
      else
        redirect_to edit_answer_comment_path(@answer, @comment)
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
