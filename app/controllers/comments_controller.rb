class CommentsController < ApplicationController

  def create
    # @comment = @movie.comments.create(:text => "This is a comment")
    @commentable = find_commentable
    @comment = @commentable.comments.build comment_params
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment Posted.' }
        format.js
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params["id"])
    redirect_to root_path unless @comment.user_id == current_user.id
    if @comment.commentable_type == "Question"
      @question = Question.find(@comment.commentable_id)
    else
      @question = Answer.find(@comment.commentable_id).question
    end
    @comment.destroy
    redirect_to question_path(@question)
  end

  def edit
    @comment = Comment.find(params["id"])
  end

  def update
    @comment.content = params[:content]
    redirect_to root_path unless @comment.user_id == current_user.id

    if @comment.save
      redirect_to question_path(@question)
    else
      flash[:error] = "Error!"
      render 'edit'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :answer_id, :question_id)
  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end
